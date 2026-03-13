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
