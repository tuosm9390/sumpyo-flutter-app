Date: 2026-03-12 10:00:00
Author: Antigravity

# 🏥 숨표 AI: 상단 UI 개편 분석 보고서 (Analysis Report)

## 1. 개요 및 목표
- **목표**: task_plan.md에 명시된 메인 페이지(Home) 상단 영역(AppBar 및 Hero Section)의 디자인 개편.
- **컨셉**: "따스한 햇살 아래, 당신의 쉼표" (Warmth, Comfort, Analog Texture).

## 2. 현재 상태 분석 (home_page.dart)
- **현재 구현**:
  - CustomScrollView 내부에 SliverAppBar를 사용하여 상단을 구성.
  - 배경은 단순한 LinearGradient(Sage Green -> 배경색).
  - 하단에 GreetingUtils.getGreeting()을 GoogleFonts.gowunBatang으로 표시.
  - 슬라이드 효과나 깊이감(아날로그 텍스처)이 부족함.
- **개선 필요 사항**:
  - 기존 SliverAppBar를 완전히 커스텀한 SumpyoAppBar 위젯으로 분리.
  - AI 약사 마스코트(assets/sumpyo_ai_icon.png)가 부드럽게 부유(Floating)하는 HeroSection 추가.
  - flutter_animate를 활용하여 진입 시 Staggered Fade-in 및 Slide-up 적용.

## 3. UI/UX Pro Max 가이드라인 적용 방안
- **Touch & Interaction**: 모든 인터랙티브 요소는 44x44px 이상의 터치 영역을 확보하고 명확한 상태 변화(hover/tap) 피드백 제공.
- **Animation**: flutter_animate를 통해 150-600ms 사이의 부드러운 전환 및 부유 애니메이션 적용.
- **Accessibility**: 아이콘 등에 적절한 Semantics 레이블 제공 및 대비(Contrast) 준수.
- **Typography & Color**:
  - 배경: #F9F8F6, 포인트: #A8B5A2, 텍스트: #4A4A4A.
  - 인사말: 고운바탕, 본문: Pretendard 적용 확인.
