Date: 2026-03-11 09:32:00
Author: Antigravity

# 🏥 숨표 AI: Flutter 앱 아키텍처 가이드 (Sumpyo AI Architecture)

**"현대적 Dart 3와 Riverpod 기반의 클린 아키텍처 설계"**

---

## 🏗️ 전체 시스템 아키텍처 (Clean Architecture)

본 프로젝트는 **기능 중심(Feature-driven)** 클린 아키텍처를 따릅니다. 각 기능은 독립적인 레이어를 가지며, 하향식 의존성을 유지합니다.

### 1. Presentation Layer (UI & State)

- **Widgets**: Flutter `StatelessWidget`, `ConsumerWidget` 등을 통한 UI 구성.
- **Providers (Riverpod)**: 위젯의 상태를 관리하고 비즈니스 로직을 연결하는 핵심 엔티티. `riverpod_generator`를 사용한 타입 안전성 확보.

### 2. Domain Layer (Logic & Interface)

- **Entities**: 앱 전반에서 사용되는 불변(Immutable) 데이터 모델 (`Freezed` 활용).
- **Use Cases**: 특정 비즈니스 로직의 추상적 정의 (필요 시 도입).
- **Repositories Interface**: 데이터 소스와의 통신을 위한 인터페이스 정의.

### 3. Data Layer (Implementation)

- **Repositories**: 도메인 레이어에서 정의한 인터페이스의 실제 구현부.
- **Data Sources**: `Dio`를 통한 Supabase REST API 통신 및 `Hive`를 이용한 로컬 저장소 접근.
- **Models (DTO)**: API 통신을 위한 데이터 변환 객체 (`json_serializable` 활용).

---

## 🔄 데이터 흐름 (Data Flow)

1. **사용자 액션 (UI)**: 위젯에서 버튼 클릭 등 이벤트 발생.
2. **프로바이더 호출 (Riverpod)**: 위젯이 `ref.read` 또는 `ref.watch`를 통해 프로바이더의 메서드를 호출.
3. **리포지토리 연동 (Data)**: 프로바이더가 리포지토리의 비즈니스 로직을 호출하여 데이터를 요청.
4. **상태 업데이트 (State)**: 리포지토리가 반환한 데이터에 따라 프로바이더의 상태(State)가 변경.
5. **UI 반응 (Re-build)**: 변경된 상태를 감지한 위젯이 자동으로 리빌드되어 사용자에게 결과 표시.

---

## 🛠️ 핵심 기술 스택 및 선택 이유

- **State Management**: `flutter_riverpod` (컴파일 타임 안전성, 프로바이더 생명주기 자동 관리).
- **Routing**: `go_router` (선언적 라우팅, 딥링크 처리 용이).
- **Network**: `dio` (인터셉터, 폼 데이터 처리 등 강력한 기능).
- **Modeling**: `freezed` & `json_serializable` (불변 객체 생성 및 JSON 직렬화 자동화).

---

## 📂 디렉토리 상세 구조 (Detailed Structure)

```text
lib/
├── core/                  # 앱 전역 설정 (Router, Theme, Utils)
├── features/              # 기능별 모듈화
│   └── home/              # 예: 홈 화면 기능
│       ├── data/          # 데이터 소스 및 리포지토리 구현
│       ├── domain/        # 비즈니스 엔티티 및 인터페이스
│       └── presentation/  # 위젯 및 프로바이더 (상태 관리)
└── shared/                # 전역 공통 위젯 및 전역 프로바이더
```
