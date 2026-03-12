# 🏥 숨표 AI: 메인 페이지 상단 디자인 개편 계획서

## 🎯 목표
- 메인 페이지(Home)의 상단 영역(AppBar 및 Hero Section)을 \"따뜻한 디지털 약방\" 컨셉에 맞춰 현대적이고 감성적으로 개편합니다.
- `/ui-ux-pro-max` 가이드라인을 준수하여 터치 피드백, 애니메이션, 타이포그래피를 최적화합니다.

## 🌈 디자인 컨셉
- **이름**: \"따스한 햇살 아래, 당신의 쉼표\"
- **핵심 키워드**: Warmth, Comfort, Analog Texture, Breathing space.
- **색상**: 
  - Background: #F9F8F6 (Warm White)
  - Accent: #A8B5A2 (Sage Green)
  - Text: #4A4A4A (Soft Charcoal)
  - Gradient: Very subtle sunset-like gradient (optional, for depth).
- **타이포그래피**: 
  - 감성 문구: 고운바탕 (Goun Batang) / 나눔명조 (Nanum Myeongjo)
  - 정보/기능: Pretendard
  - 숫자: Montserrat

## 🛠️ 주요 변경 사항
1. **CustomAppBar**:
   - 기존의 단조로운 `AppBar`를 제거하고 화면 배경과 자연스럽게 어우러지는 투명/플로팅 형태의 디자인 적용.
   - 중앙 로고 또는 앱 이름 대신, 사용자의 시간대에 맞춘 따뜻한 인사말 제공.
2. **HeroSection (상단 환영 영역)**:
   - AI 약사 캐릭터(Sumpyo mascot)가 화면 상단에서 부드럽게 부유(Floating)하는 애니메이션 추가.
   - 배경에 은은한 텍스트 또는 텍스처를 추가하여 \"종이 처방전\"의 아날로그 느낌 강화.
3. **인터랙션 및 애니메이션**:
   - `flutter_animate`를 활용하여 컴포넌트 등장 시 `staggered fade-in` 및 `slide-up` 효과 적용.
   - 상단 요소들이 사용자의 스크롤에 따라 자연스럽게 반응하도록 설계.

## 📝 단계별 수행 계획

### Phase 1: 리서치 및 분석 (Research & Analysis)
- [x] 프로젝트 핵심 철학 및 UI/UX 가이드 리서치.
- [x] 현재 `HomePage` 상단 구현 코드 분석.
- [x] `/ui-ux-pro-max` 기반 디자인 시스템 도출.

### Phase 2: 디자인 설계 (Design Strategy)
- [ ] 상세 디자인 및 컨셉 수정 계획서 작성 (현재 진행 중).
- [ ] UI 컴포넌트 구조 설계 (CustomAppBar, HeroSection).

### Phase 3: 구현 (Implementation) - Red-Green-Refactor
- [ ] `SumpyoAppBar` 커스텀 위젯 생성 또는 기존 `HomePage` 리팩토링.
- [ ] `HeroSection` 구현 및 애니메이션 적용.
- [ ] 시간대별 인사말 로직 추가 (core/utils/greeting_utils.dart 등).

### Phase 4: 검증 및 최적화 (Validation & Optimization)
- [ ] UI 레이아웃 및 애니메이션 성능 확인 (60/120fps).
- [ ] 다크 모드 및 접근성 대비 확인.
- [ ] 사용자 최종 피드백 반영.

## 🧪 테스트 전략
- `flutter test`를 통한 위젯 렌더링 확인.
- 시각적 무결성 확인 (UI 가이드라인 준수 여부).

## 🚀 완료 기준
- 상단 영역이 기존보다 더 \"따뜻하고 감성적\"으로 느껴짐.
- 애니메이션이 끊김 없이 부드럽게 작동함.
- 프로젝트의 핵심 컬러와 타이포그래피가 정확히 적용됨.
