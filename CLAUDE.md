Date: 2026-03-11 09:30:00
Author: Antigravity

# 🏥 숨표(Sumpyo) AI: 마음의 쉼표 (Flutter App Hub)

**"Flutter 네이티브의 성능으로 구현하는 가장 따뜻한 디지털 위로"**

---

## 🍌 프로젝트 핵심 철학 (Mobile Philosophy)

- **네이티브 성능 (True Native Experience)**: Flutter의 60fps/120fps 부드러운 애니메이션을 통해 사용자에게 평온함을 전달합니다.
- **현대적 상태 관리 (Type-Safe State Management)**: `Riverpod`을 활용하여 오동작 없는 견고한 앱 경험을 제공합니다.
- **상시 연결 (Constant Connection)**: 네이티브 푸시 알림과 백그라운드 서비스를 통해 AI 약사가 항상 곁에 있음을 느낄 수 있게 합니다.

---

## ⚙️ 문제 해결 완료 후 필수 워크플로우 (Post-Problem-Solving Workflow)

**모든 문제 해결이 완료된 직후, 사용자 승인 없이 아래 절차를 자동으로 실행한다.**

1. **회고 분석**: 이번 작업에서 "무엇이 작동했고 무엇이 실패했는지" 분석.
2. **핵심 규칙 도출**: 향후 동일 실수를 반복하지 않기 위한 규칙 1가지 도출.
3. **COMMON_MISTAKES.md 저장**: `doc/COMMON_MISTAKES.md`에 업데이트.
4. **LESSONS_LEARNED 저장**: `doc/LESSONS_LEARNED.md` 하단에 규칙 추가.
5. **보고**: 저장 완료 후 사용자에게 요약 보고.

---

## 📜 코딩 스타일 및 앱 개발 원칙 (App Development Principles)

- **선언적 UI (Declarative UI)**: Flutter의 위젯 구성을 최우선으로 하며 `const` 생성자를 적극 활용하여 성능을 최적화한다.
- **클린 아키텍처 (Clean Architecture)**: `features/` 기반의 폴더 구조를 유지하며, Data-Domain-Presentation 레이어를 엄격히 분리한다.
- **오프라인 우선 (Offline-First)**: `Hive` 또는 `SQLite`를 사용하여 이전에 받은 처방전을 캐싱한다.
- **엄격한 타입 안전성**: Dart 3의 강력한 타입 시스템과 `freezed`, `json_serializable`을 사용하여 런타임 에러를 방지한다.

---

## 🚀 주요 커맨드 (App Commands)

```bash
flutter run           # 앱 실행 (연결된 디바이스 또는 시뮬레이터)
flutter pub get       # 의존성 패키지 설치
flutter pub run build_runner build  # 코드 생성 (Freezed, Riverpod Generator 등)
flutter test          # 단위 및 위젯 테스트 실행
```

## 📚 관련 기술 문서 (App Architecture Modules)

| 문서명                   | 설명                                             |
| ------------------------ | ------------------------------------------------ |
| `doc/ARCHITECTURE.md`    | Flutter/Riverpod 기반 앱 아키텍처 및 데이터 흐름 |
| `doc/DATABASE.md`        | Supabase 및 로컬 DB(Hive) 연동 전략              |
| `doc/AI_LOGIC.md`        | 감정 분석 및 스타일별 프롬프트 전략              |
| `doc/UI_UX_GUIDE.md`     | Flutter 특화 디자인 및 애니메이션 가이드         |
| `doc/LESSONS_LEARNED.md` | 앱 개발 중 학습한 교훈 및 규칙 아카이브          |
