Date: 2026-03-10 15:52:00
Author: Antigravity

# ⚠️ Common Mistakes: 숨표(Sumpyo) AI 개발 시 주의사항

반복적으로 발생할 수 있는 실수와 이를 방지하기 위한 가이드입니다.

### 2026-03-11: 워크스페이스 내부 파일 읽기 및 PowerShell 명령어 호환성 이슈

- **이슈 요약 (The Problem)**:
  ead_multiple_notes 툴이 워크스페이스 내부 파일을 찾지 못하고 외부 경로(Obsidian Vault)를 참조함. 또한 PowerShell에서 dir /s /b 명령어가 잘못된 인자 인식으로 실패함.
- **실패한 접근법 (What didn't work)**: 범용적인
  ead_multiple_notes 사용 및 cmd 스타일의 dir 플래그( /s /b) 직접 사용.
- **최종 해결책 (What worked)**: 1. 내부 파일 읽기 작업에
  ead_file 툴을 명시적으로 사용함. 2. 파일 구조 파악 시 glob 툴을 사용하거나 PowerShell 전용 Get-ChildItem -Recurse를 활용함.
- **AI 행동 지침 (Lessons Learned & New Rules)**: - 워크스페이스 내부의 단일/다중 파일 읽기 시, 경로 정합성이 높은
  ead_file을 우선적으로 사용하라. - 윈도우 환경에서 파일 스캔 시 dir의 cmd 전용 플래그 대신 glob 툴을 사용하여 환경 독립성을 확보하라.

### 2026-03-11: Flutter UTF-16 인코딩 및 숨겨진 복사본 파일

- **실수**: Windows 환경에서 Dart 파일이 UTF-16 LE BOM으로 저장됨. Dart 컴파일러는 UTF-8만 지원.
- **결과**: `build_runner`가 `FormatException: Invalid UTF-8 byte` 에러로 무한 대기 상태에 빠짐.
- **함정**: `lib/` 디렉토리의 파일만 확인했으나, `android/production/`, `android/test/`, `test/` 등 하위 디렉토리에도 UTF-16 복사본이 존재했음. 일부만 수정하면 build_runner가 여전히 막힘.
- **방지**:
  1. 프로젝트 전체를 대상으로 인코딩을 일괄 검사하라 (python3로 BOM 바이트 확인).
  2. `android/` 내부의 Dart 파일은 `analysis_options.yaml`의 `exclude`로 분석 대상에서 제외하라.
  3. riverpod_annotation v2.x에서 생성된 `XyzRef` typedef가 deprecated일 경우, `// ignore: deprecated_member_use_from_same_package`로 처리하라.

### 2026-03-11: Hive Generator와 Riverpod Generator 버전 충돌

- **실수**: 최신 버전을 유지하기 위해 \hive_generator: ^2.0.1\과 \
  iverpod_generator: ^2.6.5\를 동시에 사용하려 함.
- **결과**: 두 제너레이터가 요구하는 \source_gen\ 버전이 달라 버전 충돌(Version Solving Failed)이 발생함.
- **방지**:
  1. 패키지를 추가할 때 기존 제너레이터와 의존하는 핵심 패키지(\source_gen\ 등)의 버전 제약을 확인하라.
  2. 당장 충돌 해결이 어렵다면, 무리하게 제너레이터를 고집하지 말고 Freezed의 \ oJson()\을 이용한 Map 직렬화 방식으로 전환하라.

### 260311 UI/UX 적용 시 Freezed 모델 불일치 오류

- **문제**: Prescription 엔티티에 style 필드를 추가하면서 PrescriptionModel에도 함께 추가하지 않아 build_runner 실행 시 freezed 관련 에러가 발생함.
- **해결**: 엔티티와 모델 간 필드를 일치시키고 dart run build_runner build --delete-conflicting-outputs 재실행으로 해결함.

- [Theme] 테마나 색상 상수 클래스(SumpyoColors 등)의 필드명을 변경할 때는, 해당 상수를 참조하고 있는 모든 종속 파일(home_page.dart 등)의 변수명도 반드시 함께 업데이트하여 undefined_getter 에러를 방지해야 한다.

### 2026-03-11: fl_chart + vector_math 버전 호환성 빌드 에러

- **실수**: `fl_chart: ^1.1.0`을 사용하면 Flutter SDK가 `vector_math 2.1.4`로 고정되어 있어 빌드 실패가 발생함.
- **원인**: `fl_chart 1.1.0`은 `Matrix4.translateByDouble` / `scaleByDouble` 메서드를 사용하는데, 이 메서드들은 `vector_math 2.2.0`에 추가된 것이라 `2.1.4`에는 존재하지 않음. 동시에 `fl_chart 1.1.1+`는 `vector_math ^2.2.0`을 명시적으로 요구하지만, `flutter_test`(SDK)가 `2.1.4`로 고정하여 의존성 해결 자체가 실패함.
- **함정**: `fl_chart`를 `^1.1.1`로 올리면 `flutter pub get` 자체가 실패하고, `^1.2.0`은 존재하지 않는 버전이라 역시 실패함.
- **해결**: `pubspec.yaml`에 `dependency_overrides: vector_math: ^2.2.0`을 추가하여 SDK 핀을 우회함.
- **방지**:
  1. Flutter 패키지 빌드 에러 시 `vector_math` 버전 불일치를 의심하라.
  2. `dependency_overrides`는 SDK 핀을 우회할 수 있는 합법적 수단이나, 메이저 버전 업그레이드 시에는 호환성을 반드시 검토하라.

### 2026-03-11: JSON 파싱 시 Null 타입 캐스팅 에러 (Prescription Tab)

- **실수**: 데이터 모델(`PrescriptionModel`)의 필드를 `required String`으로 선언하고, `fromJson`이나 Repository에서 `as String`으로 강제 캐스팅함.
- **결과**: 로컬 캐시 데이터에 특정 필드가 누락되어 있거나 AI 응답이 불완전할 경우, `type 'null' is not a subtype of type 'String' in type cast` 에러와 함께 화면 진입이 불가능해짐.
- **방지**: 
  1. 외부 데이터(API, JSON)와 연결된 모델 필드에는 반드시 Freezed의 `@Default('')`를 사용하여 기본값을 제공하라.
  2. JSON 맵에서 값을 읽어올 때는 `as String` 대신 `(json['key'] as String?) ?? ''` 형식을 사용하여 null-safety를 확보하라.

### 2026-03-11: 문자열 리터럴 이스케이프 노출 이슈
- **실수**: AI 응답(JSON)에 포함된 '\n' 문자열이 Dart 문자열 내에서 리터럴로 취급되어 UI에 그대로 노출됨.
- **결과**: 줄바꿈이 되지 않고 '\n\n' 글자가 사용자에게 보임.
- **방지**: 데이터 매핑 단계(toEntity 등)에서 .replaceAll(r'\n', '\n') 처리를 통해 전역적으로 문자열을 정규화할 것.

### 2026-03-12: PowerShell을 이용한 다중 라인 Dart 파일 작성 시 이스케이프 및 인코딩 이슈
- **실수**: `run_shell_command`를 통해 직접 `Set-Content`나 `echo`로 복잡한 다중 라인 Dart 코드를 작성하려 함.
- **결과**: PowerShell의 특수 문자($, \n, \, quotes) 처리 방식 차이로 인해 Dart 문법 에러가 대량 발생하거나 인코딩(UTF-16 LE BOM) 문제로 Flutter 컴파일이 실패함.
- **방지**: 
  1. 3라인 이상의 복잡한 코드 작성 시에는 `run_shell_command` 대신 **`generalist` 서브 에이전트**에게 파일 쓰기를 위임하라.
  2. 불가피하게 쉘을 사용할 경우, 단순 문자열 전달보다는 Python 스크립트를 생성하여 실행하는 방식이 안정적이나, 이 역시 파이썬 문자열 이스케이프를 주의해야 함.
  3. 항상 파일 작성 후 `flutter analyze`를 실행하여 문법적 무결성을 즉시 검증하라.


### 2026-03-12: 파일 데이터 일괄 수정 시 특수문자 이스케이프 및 구문 오류
- **실수**: PowerShell로 Dart 코드 내의 문자열(String) 데이터를 수정하거나 덮어쓸 때, 쉘 스크립트의 이스케이프가 잘못 삽입되어 불필요한 이스케이프(`\"`)가 포함됨. 이로 인해 Dart 문법 오류 및 `unnecessary_string_escapes` 경고가 발생함.
- **결과**: `flutter analyze` 실행 시 경고가 발생하고, 문법 오류로 인해 빌드가 불가능해짐.
- **방지**:
  1. 데이터를 삽입할 때 스크립트 환경과 타겟 언어(Dart) 간의 이스케이프 충돌을 피하기 위해 작은따옴표(`'`)를 사용하여 이스케이프가 불필요한 형태로 문자열을 구조화하라.
  2. 코드를 수정한 직후에는 반드시 `flutter analyze`를 실행하여 쉘 스크립트 작성 과정에서 발생한 이스케이프 문자 오염이 없는지 즉시 확인하라.
- **MainLayout 내 중복 AppBar 배치**: `MainLayout`으로 개별 화면을 감싸는 구조에서 각 페이지(예: `PrescriptionsPage`)에 별도의 `AppBar`를 중복 배치하여 시각적 불균형이 발생하는 이슈. 개별 화면에서는 `AppBar`를 제거하고 공통 레이아웃의 앱바를 활용하거나 `SliverAppBar`로 통합하는 설계가 필요함.

## 2026-03-13: 테스트 환경 설정 누락
- **실수**: `flutter test` 작성 시 `TestWidgetsFlutterBinding.ensureInitialized()` 누락 및 외부 의존성(폰트 다운로드, Hive 경로 등) 모킹 부족.
- **방지책**: 위젯 테스트 초기화 단계에 폰트 다운로드 비활성화 및 `runAsync`로 Pending Timer 제거 적용.

## 2026-03-13: Deprecated API 적용 관련 오판
- **실수**: `SharePlus.share` 등 최신 API가 구버전 패키지에서 동작하지 않을 수 있음을 간과하고 일괄 수정하여 빌드/테스트를 깨뜨림.
- **방지책**: Deprecated 경고 발생 시 공식 문서를 확인하되, 현재 프로젝트에 설치된 패키지 버전에 해당 API가 확실히 구현되어 있는지부터 점검할 것. 안전한 과도기적 방법으로 `// ignore: deprecated_member_use` 주석을 활용.
