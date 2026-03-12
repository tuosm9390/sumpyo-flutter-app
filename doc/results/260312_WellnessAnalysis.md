# 🏥 [분석 보고서] 숨표 AI: 'Wellness Routine' (웰니스 루틴) 기능

**\"매일의 정서적 회복과 성장을 위한 따뜻한 습관 형성\"**

---

## 1. 개요 및 목적 (Goal)
'숨표 AI'는 단순히 약을 처방하는 곳이 아닌, 일상 속에서 정서적 안정을 유지하도록 돕는 파트너입니다. 이를 위해 사용자가 매일 간단한 **마음 챙김 습관(Mindfulness Habit)**을 형성할 수 있도록 돕는 루틴 기능을 도입합니다.

- **핵심 목표**: 강제적인 할 일 목록이 아닌, 완료 시 따뜻한 정서적 보상을 제공하여 사용자가 지속적으로 앱을 방문하게 유도.

---

## 2. 화면 구성 및 사용자 인터페이스 (Target Screens)
- **화면명**: `WellnessPage`
- **위치**: `MainLayout`의 하단 네비게이션 바에 새롭게 추가될 세 번째 탭.
- **레이아웃 특징**:
    - 스크롤 가능한 단일 페이지 구성.
    - 기존 '처방전'이나 '상담' 화면과 일관된 **Warm White (#F9F8F6)** 배경색 사용.

---

## 3. 핵심 UI 컴포넌트 (Key Components)

### A. MissionHero (오늘의 대표 미션)
- **설명**: 화면 최상단에서 그날의 가장 중요한 메인 미션을 강조.
- **UI 특징**: 
    - 감성적인 자연 배경이나 따뜻한 색감의 그라데이션 적용.
    - 미션 완료 전후의 시각적 변화가 가장 큼 (예: 완료 시 배경이 더 밝아지거나 캐릭터가 축하 모션).

### B. MissionList (카테고리별 미션 리스트)
- **설명**: 오늘의 하위 미션들을 카테고리별로 정렬하여 보여주는 목록.
- **카테고리 구성**:
    - **호흡 (Breathing)**: 1분간 깊은 숨 들이쉬기 등.
    - **감사 (Gratitude)**: 오늘 감사한 일 한 가지 기록하기.
    - **행동 (Action)**: 창밖 풍경 5분 바라보기 등.
- **UI 특징**: 단순한 체크박스 대신, 터치 시 통통 튀는 애니메이션과 함께 꽃이 피거나 빛이 나는 이펙트 제공.

### C. WeeklyProgress (주간 진행도 시각화)
- **설명**: 최근 7일간의 루틴 달성 현황을 직관적으로 표시.
- **UI 특징**:
    - 수평형 프로그레스 바(Horizontal Bar) 또는 7개의 동그란 아이콘 형태.
    - 달성한 날에는 특별한 스탬프나 캐릭터 아이콘 표시.

---

## 4. 데이터 설계 및 관리 전략 (Data Strategy)

### A. 데이터 모델 (Entity)
- **WellnessMission**:
    - `id`: 고유 식별자 (UUID)
    - `title`: 미션 제목
    - `category`: 호흡, 감사, 행동 등 (Enum)
    - `isCompleted`: 완료 여부 (Boolean)
    - `completedAt`: 완료 시각 (DateTime?)
    - `targetDate`: 미션 수행 대상 날짜 (DateTime)

### B. 상태 관리 (Riverpod)
- `WellnessNotifier` (StateNotifier 또는 AsyncNotifier):
    - 미션 목록 로드, 상태 업데이트(완료 처리), 진행률 계산 로직 담당.

### C. 로컬 데이터 지속성 (Persistence)
- **전략**: 정식 Hive 데이터베이스 마이그레이션 전까지는 기존 `PrescriptionLocalDataSource`와 동일한 **JSON 파일 기반 저장** 방식 채택.
- **파일**: `wellness_data.json`
- **이유**: 빠른 프로토타이핑 및 기존 데이터 레이어와의 구조적 통일성 유지.

---

## 5. UI 스타일 및 인터랙션 가이드 (UI Style)

### A. 시각적 테마 (Warm Digital Pharmacy)
- **Color Palette**: 
    - **Sage Green**, **Warm Beige**, **Soft Peach** 등의 파스텔 톤을 사용하여 눈의 피로를 최소화.
- **Typography**: 
    - 정보 전달은 **Pretendard**, 감성적인 문구는 **나눔명조**를 혼용.

### B. 애니메이션 (flutter_animate)
- **피드백**: 미션 항목 탭 시 `Scale` 및 `Fade` 애니메이션을 통한 부드러운 전환.
- **달성 피드백**: 주간 미션 모두 완료 시 화면 전체에 은은한 빛이 퍼지는 `Shimmer` 효과나 `Particle` 이펙트 적용.
- **Haptic**: 미션 완료 시 `HapticFeedback.lightImpact()`를 통한 촉각적 피드백 제공.

---
**Date**: 2026-03-12
**Author**: Antigravity (Sumpyo AI Dev Team)
