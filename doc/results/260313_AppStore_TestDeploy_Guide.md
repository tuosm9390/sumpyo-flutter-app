Date: 2026-03-13 13:56:00
Author: Antigravity

# 📱 숨표 앱 - 앱스토어 테스트 배포 가이드

## 📊 현황 분석
- **앱 이름**: sumpyo_app
- **버전**: 1.0.0+1
- **Android App ID**: `com.sumpyo.sumpyo_app`
- **iOS Bundle ID**: Runner.xcodeproj 설정 필요
- **⚠️ 주의**: Android 릴리즈 서명이 debug 키로 설정됨 → 배포 전 수정 필요

---

## 🍎 iOS - TestFlight 테스트 배포

### 전제 조건
- [ ] macOS + Xcode 15+ 환경
- [ ] Apple Developer Program 가입 (연 $99)
- [ ] App Store Connect 앱 등록 완료

### 단계별 절차

#### 1. Bundle ID 설정
```bash
# Xcode에서 ios/Runner.xcworkspace 열기
open ios/Runner.xcworkspace
```
- Xcode: `Runner` 타겟 → `Signing & Capabilities`
- Bundle Identifier: `com.sumpyo.sumpyoapp` (예시, 실제 값 확인)
- Team: Apple Developer 계정 선택

#### 2. 앱 버전 설정 (pubspec.yaml)
```yaml
version: 1.0.0+1  # format: {version_name}+{build_number}
```

#### 3. Release 빌드 생성
```bash
cd c:\Users\tuosm\.gemini\antigravity\scratch\sumpyo-flutter-app

# iOS Release 빌드 (macOS에서 실행)
flutter build ipa --release
```

빌드 결과물: `build/ios/ipa/sumpyo_app.ipa`

#### 4. Xcode로 Archive & Upload
```bash
# 또는 Xcode 직접 사용
# Product → Archive → Distribute App → App Store Connect
```

#### 5. TestFlight 배포
1. [App Store Connect](https://appstoreconnect.apple.com) 접속
2. 내 앱 → sumpyo_app → `TestFlight` 탭
3. 업로드된 빌드 선택
4. 테스터 이메일 추가 (내부/외부 테스터)
5. 외부 테스터: 최초 1회 Apple 심사 필요 (~1-2일)

---

## 🤖 Android - 내부 테스트 트랙 배포

### 전제 조건
- [ ] Google Play Console 계정 ($25 1회성 등록비)
- [ ] 앱 등록 완료

### 단계별 절차

#### 1. 서명 키 생성 (최초 1회)
```bash
# keytool로 키스토어 생성
keytool -genkey -v -keystore android/app/upload-keystore.jks \
  -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload

# 입력 정보:
# - 비밀번호, 이름, 조직, 국가 코드 (KR)
```

#### 2. key.properties 파일 생성
```bash
# android/key.properties 파일 생성 (gitignore에 추가!)
```

```properties
storePassword=<키스토어_비밀번호>
keyPassword=<키_비밀번호>
keyAlias=upload
storeFile=../app/upload-keystore.jks
```

#### 3. android/app/build.gradle 수정
```groovy
// 파일 상단에 추가
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    // ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release  // debug → release 로 변경
        }
    }
}
```

#### 4. .gitignore에 키 파일 추가
```gitignore
# android/.gitignore에 추가
key.properties
**/*.jks
**/*.keystore
```

#### 5. Release APK/AAB 빌드
```bash
# App Bundle (Play Store 권장)
flutter build appbundle --release

# 결과: build/app/outputs/bundle/release/app-release.aab
```

#### 6. Play Console 내부 테스트 업로드
1. [Play Console](https://play.google.com/console) → 앱 선택
2. `테스트` → `내부 테스트` → `새 출시 버전 만들기`
3. `app-release.aab` 업로드
4. 테스터 이메일 추가 (최대 100명)
5. 검토 없이 즉시 배포 가능 ✅

---

## ⚡ 빠른 대안: Firebase App Distribution

서명 없이도 APK를 즉시 팀에게 배포할 수 있는 방법:

```bash
# Debug APK 빌드 (서명 불필요)
flutter build apk --debug

# Firebase CLI로 배포
firebase appdistribution:distribute build/app/outputs/flutter-apk/app-debug.apk \
  --app <FIREBASE_APP_ID> \
  --testers "tester@example.com" \
  --release-notes "테스트 빌드"
```

---

## 📋 배포 전 체크리스트

### 공통
- [ ] `.env` 파일 프로덕션용 API 키 확인
- [ ] Supabase URL/Key 프로덕션 설정 확인
- [ ] Google Generative AI 키 유효성 확인
- [ ] 앱 아이콘 설정 완료 여부
- [ ] 스플래시 스크린 설정 완료 여부

### iOS 전용
- [ ] Bundle ID 확정
- [ ] Signing 인증서 설정
- [ ] Privacy manifest 작성 (iOS 17+)
- [ ] Entitlements 파일 확인

### Android 전용
- [ ] 릴리즈 서명키 생성 및 설정
- [ ] `key.properties` gitignore 추가
- [ ] minSdk 버전 확인

---

## 🔑 권장 배포 순서

```
1단계 (즉시 가능): Firebase App Distribution으로 Android APK 공유
2단계 (1-2일): Android Play Console 내부 테스트 트랙
3단계 (2-7일): iOS TestFlight (외부 테스터는 Apple 심사 필요)
```
