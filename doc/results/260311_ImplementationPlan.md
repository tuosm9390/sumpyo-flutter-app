Date: 2026-03-11 10:00:00
Author: Antigravity

# [숨표 AI] 시스템 통합 및 안정화 단계 작업 진행 계획서

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Flutter 네이티브 환경에서 사용자의 마음을 위로하는 AI 약사 서비스의 핵심 기능을 완성하고, 클린 아키텍처 기반의 안정적인 통합 시스템을 구축합니다.
**Architecture:** Feature-driven Clean Architecture를 적용하여 기능을 모듈화하고, Riverpod을 통한 단방향 데이터 흐름을 보장하며, Supabase와 Hive를 결합한 오프라인 우선(Offline-First) 동기화 전략을 사용합니다.
**Tech Stack:** Flutter 3, Riverpod (Generator), Supabase, Hive, Gemini 1.5 Flash API, Freezed, Go Router.

---

### [DONE] Task 1: 핵심 인프라 및 전역 설정 (Core Setup)

**Files:**

- Create: `lib/core/network/dio_client.dart`
- Create: `lib/core/supabase/supabase_config.dart`
- Modify: `lib/main.dart`
- Test: `test/core/network/dio_client_test.dart`

**Step 1: Supabase 및 Dio 클라이언트 초기화 코드 작성**
**Step 2: main.dart에서 앱 초기화 로직 강화**
**Step 3: Commit**

### [DONE] Task 2: 홈 피처 데이터 레이어 구현 (Data Layer)

**Files:**

- Create: `lib/features/home/domain/entities/prescription.dart`
- Create: `lib/features/home/data/models/prescription_model.dart`
- Create: `lib/features/home/data/repositories/prescription_repository_impl.dart`
- Test: `test/features/home/data/prescription_repository_test.dart`

**Step 1: Freezed를 사용한 불변 데이터 엔티티 정의**
**Step 2: 리포지토리 인터페이스 및 구현체 작성**
**Step 3: Commit**

### [DONE] Task 3: AI 엔진 통합 (Gemini 1.5 Flash)

**Files:**

- Create: `lib/features/home/data/datasources/ai_remote_datasource.dart`
- Modify: `doc/AI_LOGIC.md`
- Test: `test/features/home/data/ai_datasource_test.dart`

**Step 1: Gemini API 호출 서비스 작성**
**Step 2: API 응답 JSON 파싱 및 예외 처리 로직 검증**
**Step 3: Commit**

### [DONE] Task 4: 오프라인 캐싱 시스템 (Hive Integration)

**Files:**

- Create: `lib/features/home/data/datasources/prescription_local_datasource.dart`
- Modify: `doc/DATABASE.md`
- Test: `test/features/home/data/local_datasource_test.dart`

**Step 1: Hive Box 설정 및 처방전 저장/조회 로직 구현**
**Step 2: 오프라인 환경 테스트 (비행기 모드 시뮬레이션)**
**Step 3: Commit**

### [DONE] Task 5: UI/UX 고도화 및 최종 통합 (Polishing)

**Files:**

- Modify: `lib/features/home/presentation/pages/home_page.dart`
- Modify: `lib/features/home/presentation/providers/prescription_provider.dart`
- Modify: `doc/UI_UX_GUIDE.md`

**Step 1: Riverpod Generator를 사용한 상태 관리 프로바이더 작성**
**Step 2: Hero 애니메이션 및 햅틱 피드백 적용**
**Step 3: 최종 빌드 및 안정성 검사**
**Step 4: Commit**
