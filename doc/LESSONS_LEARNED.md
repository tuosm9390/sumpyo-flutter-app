Date: 2026-03-10 15:50:00
Author: Antigravity

# 📝 Lessons Learned: 숨표(Sumpyo) AI 개발 교훈

작업 중 발생한 기술적 난관과 이를 통해 얻은 핵심 인사이트를 기록합니다.

### 2026-03-11: 워크스페이스 내부 파일 읽기 및 PowerShell 명령어 호환성 이슈

- **AI 행동 지침 (New Rules)**: 워크스페이스 내부의 파일 읽기 시
  ead_file을 우선 사용하고, 파일 스캔 시 glob 툴을 활용하여 PowerShell 명령어 호환성 이슈를 방지하라.

### 2026-03-11: Flutter 빌드 에러 수정 — UTF-16 인코딩 & build_runner 교훈

- **핵심 규칙**: Flutter 프로젝트에서 build_runner가 특정 파일에서 멈출 때, 해당 파일의 **인코딩**을 가장 먼저 의심하라. `lib/`만이 아닌 프로젝트 전체 Dart 파일을 검사해야 한다.
- **작동한 것**: Python으로 프로젝트 전체 `.dart` 파일을 순회하며 UTF-16 BOM(`FF FE`)을 감지하고 UTF-8로 일괄 변환.
- **실패한 것**: `lib/`만 변환 → `test/core/network/dio_client_test.dart`가 누락되어 build_runner가 계속 무한 대기.
- **분석 제외 처리**: `android/production/`처럼 분석 대상이 아닌 경로는 `analysis_options.yaml`의 `analyzer.exclude`에 추가하라.

### 2026-03-11: 버전 충돌 대응 및 유연한 구조 설계

- **핵심 규칙**: 최신 라이브러리 간의 버전 충돌 시 우회 경로를 확보하라.
- \hive_generator\와 같이 코드 생성 도구끼리 의존성이 충돌할 때는, 기본 JSON 직렬화(Map<String, dynamic>)를 활용하여 로컬 스토리지를 구현함으로써 빌드 문제를 신속하게 피할 수 있다.

### [260311] Freezed 사용 시 Entity와 Model의 동기화

- **규칙**: Domain Layer의 Entity 클래스(Prescription) 필드를 수정할 때는 반드시 Data Layer의 Model 클래스(PrescriptionModel)와 oEntity(), romEntity() 매퍼 함수도 동시에 업데이트한 후 uild_runner를 실행해야 한다.

- [Theme] 테마나 색상 상수 클래스(SumpyoColors 등)의 필드명을 변경할 때는, 해당 상수를 참조하고 있는 모든 종속 파일(home_page.dart 등)의 변수명도 반드시 함께 업데이트하여 undefined_getter 에러를 방지해야 한다.

### 2026-03-11: fl_chart + vector_math SDK 핀 충돌 해결

- **핵심 규칙**: Flutter에서 서드파티 패키지가 `Matrix4` 메서드 미정의 에러를 일으키면, `vector_math` 버전 불일치를 가장 먼저 의심하고 `dependency_overrides`로 해결하라.
- **작동한 것**: `pubspec.yaml`에 `dependency_overrides: vector_math: ^2.2.0` 추가 → `flutter pub get` 성공 → `flutter build apk --debug` 빌드 성공.
- **실패한 것**: `fl_chart: ^1.1.1` 또는 `^1.2.0`으로 버전만 올리는 방식 → `flutter_test` SDK가 `vector_math 2.1.4`를 핀으로 고정하여 의존성 해결 자체가 실패함.
- **교훈**: Flutter SDK가 의존성을 핀으로 고정(pinned)할 경우, 패키지 버전만 올려서는 해결이 안 됨. `dependency_overrides`를 통해 SDK 핀을 명시적으로 우회해야 하며, 이는 마이너 버전 업그레이드(`2.1.4 → 2.2.0`)의 경우 일반적으로 안전하다.

### 2026-03-11 16:45:00

윈도우(win32) 환경의 PowerShell 제약 사항을 항상 염두에 두고, 복잡한 문자열이 포함된 명령은 쉘 이스케이프 대신 파일 쓰기 도구를 우선적으로 사용한다.

### 2026-03-11: 데이터 모델의 Null-Safety 방어막 구축

- **핵심 규칙**: 외부 데이터(API, Local JSON)를 객체로 변환할 때는 반드시 모든 필드에 대해 null 방어 로직을 포함하라.
- **작동한 것**: `PrescriptionModel`의 모든 필드에 `@Default('')`를 추가하고, Repository의 명시적 캐스팅을 `?? ''`를 사용한 안전한 방식으로 변경.
- **교훈**: 앱이 성장함에 따라 데이터 구조가 변하거나(Migration), 불안정한 네트워크 환경에서 불완전한 응답이 올 수 있다. 이때 `required`와 `as String`에만 의존하면 앱 전체가 크래시될 수 있으므로, 모델 레벨에서 기본값을 제공하는 것이 가장 견고한 해결책이다.

### 2026-03-11: 데이터 정규화의 레이어 분리
- **핵심 규칙**: UI 레이어에서 replaceAll 등 데이터 가공 로직을 반복하지 말고, 데이터 모델의 toEntity() 또는 팩토리 메서드에서 전역적으로 처리하라.
- **작동한 것**: UI 코드의 수동 문자열 치환을 제거하고 PrescriptionModel.toEntity()에서 일괄 정규화 수행.
- **교훈**: 데이터의 일관된 표현을 보장하고 UI 코드를 선언적으로 유지할 수 있다.

### 2026-03-12: 복잡한 Dart 소스 코드 생성 전략
- **핵심 규칙**: 멀티라인, 특수문자($ 등)가 포함된 코드를 생성할 때는 쉘(PowerShell)의 인라인 명령보다는 `generalist` 에이전트 위임이나 Python 스크립트 기반 생성을 우선하라.
- **작동한 것**: `generalist` 에이전트에게 전체 파일 내용을 전달하여 쓰기 작업을 위임함.
- **실패한 것**: PowerShell `Set-Content`와 here-string(@' ... '@)을 사용하여 직접 작성을 시도했으나, Dart 내부의 $ 기호나 \n 처리 과정에서 이스케이프 오류가 반복 발생함.
- **교훈**: OS마다 쉘의 특수문자 처리 규칙이 다르므로, 코드 무결성이 중요한 작업에서는 플랫폼 독립적인 에이전트 도구(generalist)를 사용하는 것이 가장 안전하고 효율적이다.

### 2026-03-12: Dart 문자열 리터럴과 자동화 도구간의 이스케이프 충돌
- **핵심 규칙**: 스크립트(PowerShell 등)를 사용해 Dart 코드에 문자열 데이터를 주입할 경우, 작은따옴표(`'`)로 문자열을 묶어 내부에 불필요한 이스케이프 처리가 필요 없도록 구조화하라.
- **작동한 것**: 데이터 리스트 작성 시 `\"` 형태의 이스케이프 대신 Dart에서 허용되는 단일 따옴표(`'`)를 활용하고 내부에 큰따옴표가 필요 없는 문장으로 우회하여 `unnecessary_string_escapes` 경고를 완벽히 해결함.
- **교훈**: 문자열을 다루는 자동화 작업에서는 스크립트 언어와 타겟 언어(Dart)의 특수 문자 처리 방식이 충돌하기 쉽다. 코드를 생성할 때는 최대한 단순하고 이스케이프가 필요 없는 문자열 포맷을 설계해야 후속 빌드 에러를 방지할 수 있다.
- **복합 UI 스크롤 최적화 (Flutter Sliver Patterns)**: 고해상도 차트, 애니메이션 히어로 섹션, 그리고 대량의 리스트가 공존하는 화면에서 `CustomScrollView`와 `Sliver` 패턴은 60/120fps의 부드러운 성능을 보장하는 필수 요소임을 재확인함.
- **정서적 UX 설계 (Analog Comfort Design)**: 시간대별 동적 인사말(`GreetingUtils`)과 마스코트의 부유 애니메이션(`FloatingMotion`)을 결합함으로써 사용자와 앱 간의 정서적 유대감을 강화하는 '아날로그 위로'의 효과를 극대화함.
Date: 2026-03-13 10:15:00
Author: Antigravity

# 코드 품질 및 문제 해결 규칙

## 1. Widget Test에서의 Font와 Hive 처리
- **문제**: Widget Test 구동 시 `PathProvider`나 `GoogleFonts`가 모킹되지 않아 테스트가 실패하거나 보류(Pending Timer)되는 현상이 발생.
- **교훈**: `flutter test` 환경은 실제 앱과 다르므로 `TestWidgetsFlutterBinding.ensureInitialized()`를 호출해야 하며, `GoogleFonts.config.allowRuntimeFetching = false`로 폰트 다운로드를 막아야 합니다.
- **해결책**:
  ```dart
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
  });
  ```

## 2. 비동기 BuildContext 사용
- **문제**: 비동기 호출 이후 `if (prescription != null && mounted)`와 같이 작성하면 린터에서 여전히 `use_build_context_synchronously` 경고가 발생합니다.
- **교훈**: 조건식 안에서 묶어 쓰지 말고, 비동기 호출 직후 즉시 반환하는 가드 문법을 적용해야 컴파일러가 완벽하게 인지합니다.
- **해결책**: `if (!context.mounted) return;`

## 3. Deprecated API의 보수적 접근
- **교훈**: 서드파티 패키지 업데이트로 인한 API 변경 시 (예: `Share.shareXFiles` -> `SharePlus.share`), 패키지 내부 버전에 따라 최신 API가 바로 적용되지 않을 수 있습니다. 완벽한 마이그레이션 전략이 확립되기 전까지는 `// ignore: deprecated_member_use`로 안정성을 우선 확보하는 것이 안전합니다.

- **규칙 14 (Android Build Standard)**: 안드로이드 빌드 충돌 발생 시, 라이브러리 버전을 강제 고정하기보다는 AGP 및 Kotlin 버전을 프로젝트 요구 사항에 맞는 최신 안정화 버전(AGP 8.6+, Kotlin 2.1+)으로 일관되게 업그레이드하는 것이 더 근본적인 해결책이다. (2026-03-13)

### 2026-03-13: UI 공간 최적화 및 테두리 곡률(Radius) 일관성

- **핵심 규칙**: 상단 앱바(`SliverAppBar`)와 히어로 섹션이 결합된 레이아웃에서 공간이 협소하게 느껴질 경우, 앱바의 `toolbarHeight`와 히어로 섹션의 높이를 동시에 조정하여 시각적 균형을 맞추라. 또한, 카드가 화면 상단에서 시작될 때는 `BorderRadius.only` 대신 `BorderRadius.circular`를 사용하여 모든 모서리에 일관된 곡률을 제공함으로써 디자인의 완성도를 높여야 한다.
- **작동한 것**: `SumpyoAppBar` 높이를 `120 -> 100`으로, `_MissionHero` 높이를 `340 -> 300`으로 줄임. `BorderRadius.circular(48)`을 적용하여 상단 각진 부분을 둥글게 수정함.
- **교훈**: 사용자는 화면 상단의 여백과 테두리의 미세한 차이에서 앱의 완성도를 느낀다. 특히 카드형 UI가 상단에 배치될 때는 모든 모서리의 곡률을 확인하는 습관이 필요하다.

### 2026-03-13: 배경 융합 디자인 (Soft Glow & Edge Blurring)

- **핵심 규칙**: 특정 섹션(Container)을 페이지 배경과 자연스럽게 연결하려면, 경계선을 명확히 하는 대신 섹션의 배경색과 유사한 색상으로 큰 `blurRadius`와 `spreadRadius`를 가진 `BoxShadow`를 적용하라. 이는 '경계'가 아닌 '빛의 확산(Glow)'처럼 보여 정서적이고 부드러운 UX를 제공한다.
- **작동한 것**: `_MissionHero`에 `BoxShadow(blurRadius: 40, spreadRadius: 10)` 적용. `SumpyoAppBar` 타이틀의 불필요한 상단 패딩 제거.
- **교훈**: 선언적 UI에서 디자인의 미세한 '공간'과 '그림자' 처리는 앱의 감성적 품질(Emotional Quality)을 결정짓는 핵심 요소이다.

### 2026-03-13: 시간대 인식 오류 방지 (DateTime & Timezone)

- **핵심 규칙**: 사용자 기기의 현지 시간을 정확히 반영해야 하는 기능(인사말, 알람 등)에서 `DateTime.now()`가 이미 로컬 시간을 보장하므로 불필요한 `toLocal()` 처리를 제거하여 예측 가능성을 높이라. 또한, 테스트 단계에서 특정 시간을 주입할 수 있도록 `DateTime? now` 파라미터를 제공하여 엣지 케이스(예: 17:00 정각)를 철저히 검증하라.
- **작동한 것**: `GreetingUtils`에 주입 가능한 `now` 파라미터 추가 및 17:00 경계 조건 유닛 테스트 통과.
- **교훈**: 앱이 글로벌 서비스로 확장될 경우 서버와의 UTC 통신이 필수적이지만, 단순 UI 인사말은 기기 로컬 시간에 의존하는 것이 가장 안전하다.

### 2026-03-13: 글로벌 타임존 대응 및 디버깅 가시성

- **핵심 규칙**: 전 세계 사용자를 대상으로 하는 시간 기반 UI(Greeting 등)에서는 기기의 로컬 타임존 설정을 우선하되, 개발자 로그에 `timeZoneName`과 `timeZoneOffset`을 명시적으로 남겨 환경별 차이를 즉시 식별할 수 있도록 하라. 이는 사용자가 수동으로 타임존을 조작하거나 해외 여행 중인 상황에서도 정확한 UX를 제공하는 기반이 된다.
- **작동한 것**: `GreetingUtils`에 `dev.log` 진단 추가 및 글로벌 시간대 시뮬레이션 테스트 통과.
- **교훈**: 사용자의 "위치"는 물리적 GPS 좌표보다 "체감하는 타임존 시간"이 UX 관점에서 더 중요할 때가 많다.

### 2026-03-13: 탭 이동 시 UI 깜빡임 방지 및 상태 유지 (Warm Start)

- **핵심 규칙**: 사용자가 탭을 전환할 때 데이터가 잠깐 사라졌다가 나타나는 "깜빡임" 현상을 방지하려면, 핵심 데이터 프로바이더에 `@Riverpod(keepAlive: true)`를 적용하라. 또한, `build()` 메서드에서 초기 빈 값을 즉시 반환하지 말고 `FutureOr`를 사용하여 Riverpod의 비동기 로딩 상태(`AsyncValue.loading`)를 UI가 정확히 인지하도록 설계해야 한다.
- **작동한 것**: `WellnessNotifier`와 `PrescriptionNotifier`에 `keepAlive: true` 적용. `WellnessPage`에서 `AsyncValue.when()`을 통한 로딩 처리.
- **교훈**: 사용자는 0.1초의 "데이터 없음" 문구에서도 앱의 불안정성을 느낀다. 메모리 캐싱과 명확한 로딩 상태 분리는 고품질 UX의 기본이다.

### 2026-03-13: 정밀 시간 비교 및 4단계 인사말 로직

- **핵심 규칙**: 일출/일몰과 같이 '분' 단위의 변화가 중요한 시간 기반 UI 로직에서는 단순히 `DateTime.now().hour` 숫자 비교를 지양하고, `DateTime.isBefore()` 또는 `isAfter()`를 사용하여 객체 간 정밀 비교를 수행하라. 이는 경계 시간(예: 07:30)에서의 오작동을 원천 차단하며, 위치 기반 API 데이터 주입 시 완벽한 싱크를 보장한다.
- **작동한 것**: 새벽-아침-점심-저녁 4단계 분기 및 `isBefore` 기반 정밀 로직 구현.
- **교훈**: 사용자의 감성은 '시간'이라는 숫자보다 '빛의 유무(일출/일몰)'에 더 민감하게 반응하므로, 로직 역시 그 정밀도를 따라가야 한다.

### 2026-03-13: 위치 기반 동적 API 연동 (일출/일몰 인사말)

- **핵심 규칙**: 사용자의 위치나 환경에 따라 변하는 데이터(Sunrise/Sunset)를 UI에 반영할 때는 `Riverpod`의 `AsyncValue`를 사용하여 로딩 상태를 관리하고, 데이터 획득 실패 시에도 서비스가 중단되지 않도록 '도메인 지식에 기반한 기본값(예: 06시 일출, 18시 일몰)'을 제공하라.
- **작동한 것**: `geolocator` + `Sunrise-Sunset API` + `GreetingUtils` 연동.
- **교훈**: 기술적 정확도(API 호출)보다 중요한 것은 어떤 상황에서도 사용자에게 어색하지 않은 문구를 보여주는 '안정적인 감성'이다.

### 2026-03-13: UI 레이어의 중복 검증 지양 (Source of Truth 신뢰)

- **핵심 규칙**: 데이터 프로바이더(Riverpod 등)에서 이미 특정 조건(예: 날짜, 권한)에 따라 필터링된 리스트를 제공하고 있다면, UI 위젯 내부에서 동일한 조건으로 클릭 가능 여부(`onTap`) 등을 중복 제어하지 말라. 기기 시계의 미세한 차이나 로직상의 경계값 불일치로 인해 사용자에게 기능이 차단된 것처럼 보이는(Disabled) 심각한 UX 저하를 초적할 수 있다.
- **작동한 것**: `_MissionItem`의 `isToday` 비교 로직 제거.
- **교훈**: UI는 데이터의 상태를 보여주는 데 집중하고, 비즈니스 규칙은 프로바이더 레벨에서 일원화하여 관리해야 견고한 앱을 만들 수 있다.
