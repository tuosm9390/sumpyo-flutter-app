# 🏥 마음 약방 (구 숨표 AI)

Flutter 기반으로 제작된 모바일 심리 치유 앱입니다. 사용자의 감정을 분석하고 따뜻한 위로와 개인화된 처방전을 제공합니다.

## 🛠 Tech Stack
- **Framework**: Flutter 3.27.4
- **Language**: Dart 3.6.2
- **State Management**: Riverpod 2.x
- **Routing**: GoRouter
- **Storage**: Supabase (Remote), Hive (Local Cache)
- **UI Architecture**: Clean Architecture (Feature-driven)

## 🚀 시작하기

### 1. 환경 설정
- Flutter SDK가 설치되어 있어야 합니다.
- Android Studio 또는 VS Code (Flutter Extension 설치됨)를 사용하세요.

### 2. 의존성 설치
```bash
flutter pub get
```

### 3. 코드 생성 (Freezed, Generator 등 사용 시)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. 앱 실행
```bash
flutter run
```

## 📂 프로젝트 구조
- `lib/core`: 라우팅, 테마, 공통 유틸리티 등 핵심 설정
- `lib/features`: 각 기능별 도메인, 데이터, 프리젠테이션 레이어
- `lib/shared`: 앱 전역에서 사용되는 공통 위젯 및 프로바이더
- `doc/`: 상세 기술 문서 및 설계 가이드

## 📄 License
© 2026 Sumpyo AI. All rights reserved.

