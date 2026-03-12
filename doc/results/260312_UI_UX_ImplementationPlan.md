Date: 2026-03-12 10:00:00
Author: Antigravity

# 🏥 숨표 AI: 상단 UI 개편 구현 계획서 (Implementation Plan)

## Phase 1: 위젯 구조 분리 및 파일 생성
- **파일 생성**:
  - lib/features/home/presentation/widgets/sumpyo_app_bar.dart
  - lib/features/home/presentation/widgets/hero_section.dart
- **목적**: home_page.dart의 복잡도를 낮추고 각 컴포넌트의 책임을 명확히 분리 (Clean Architecture 원칙 준수).

## Phase 2: SumpyoAppBar 구현 (sumpyo_app_bar.dart)
- **형태**: SliverAppBar (또는 커스텀 SliverPersistentHeaderDelegate)를 상속/활용하여 스크롤 시 축소되는 투명/플로팅 앱바 구현.
- **기능**:
  - 배경은 스크롤 시 블러(Blur) 처리되거나 배경색에 자연스럽게 스며드는 효과 적용.
  - 중앙 또는 좌측 상단에 로고 배치 (선택적).
  - 텍스트가 아닌 형태적 요소로 안정감을 줌.

## Phase 3: HeroSection 구현 (hero_section.dart)
- **형태**: 인사말과 Sumpyo 마스코트를 포함하는 Sliver 위젯 (SliverToBoxAdapter 활용).
- **구성 요소**:
  - 상단: GreetingUtils.getGreeting() (고운바탕, 강조).
  - 하단: GreetingUtils.getSubGreeting() (Pretendard, 보조 설명).
  - 우측 또는 배경: assets/sumpyo_ai_icon.png 이미지를 flutter_animate의 loop 및 moveY 등을 조합하여 부드러운 Floating 효과(위아래로 둥둥 떠있는 효과) 적용.
  - 컨테이너 배경에 은은한 텍스처 또는 노이즈(선택적)와 부드러운 그래디언트 추가.

## Phase 4: HomePage 리팩토링 및 통합
- home_page.dart에서 기존 SliverAppBar와 인사말 Text 위젯들을 제거.
- 새로 만든 SumpyoAppBar와 HeroSection을 CustomScrollView의 최상단 slivers 배열에 추가.
- 전체적인 스크롤 동작과 애니메이션 연계(Staggered Fade-in) 테스트.

## Phase 5: 검증 (Validation)
- flutter run으로 화면 렌더링 및 60fps 애니메이션 끊김 여부 확인.
- 라이트/다크 모드 색상 대비 검증 (#F9F8F6, #A8B5A2 호환성).
- 디바이스 해상도별 레이아웃 깨짐 확인.
