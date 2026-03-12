Date: 2026-03-12 00:35:00 
Author: Antigravity

# 🏥 숨표 AI: 메인 페이지 상단 디자인 개편 및 컨셉 수정 계획서

**\"따스한 햇살 아래, 당신의 쉼표\" - 현대적 모션과 아날로그 감성이 만나는 상단 영역 개편**

---

## 🍌 1. 개편 배경 및 목적 (Background & Goals)
- **배경**: 현재의 `AppBar`와 헤더 영역은 기능적으로는 충실하나, \"마음 약방\"이라는 감성적 컨셉을 전달하기에는 다소 단조롭고 정적임.
- **목적**: 
  - 사용자에게 첫 대면부터 따뜻함과 편안함을 줄 수 있는 시각적 경험(UX) 제공.
  - Flutter의 네이티브 애니메이션 성능을 활용하여 앱이 \"살아있는 생명체\"처럼 느껴지게 함.
  - 사용자의 시간대와 감정에 공감하는 인사말을 통해 AI 약사와의 친밀감 형성.

---

## 🎨 2. 디자인 전략 (Design Strategy)

### 2.1 시각적 스타일: \"Soft Analog & Glassmorphism\"
- **배경 텍스처**: 순색보다는 미세한 종이 질감(Grain) 또는 부드러운 그라데이션을 배경에 적용하여 아날로그 감성 강화.
- **레이아웃**: 
  - **CustomAppBar**: 상단바의 경계를 허물고 배경과 하나로 통합된 디자인. 스크롤 시에만 불투명한 Glassmorphism 효과가 나타남.
  - **Hero Section**: 화면 상단의 30~40%를 차지하며, 사용자의 고민을 듣기 전 충분한 시각적 여유(Negative Space)를 제공.

### 2.2 타이포그래피 및 문구 (Typography & Copywriting)
- **폰트**: 
  - 인사말(Heading): **고운바탕 (Goun Batang)** - 부드러운 세리프가 주는 위로의 힘 활용.
  - 보조 문구(Body): **Pretendard** - 가독성 확보.
- **메시지 컨셉**:
  - (아침) \"좋은 아침이에요. 오늘 당신의 마음은 어떤 색인가요?\"
  - (오후) \"잠시 쉬어가도 괜찮아요. 따뜻한 차 한 잔과 함께 이야기를 들려주세요.\"
  - (저녁) \"수고 많았던 오늘, 당신의 지친 마음을 이곳에 잠시 내려놓으세요.\"

### 2.3 애니메이션 가이드 (Animation Strategy)
- **Mascot Motion**: 숨표 캐릭터(Sumpyo Pharmacist)가 `FloatingMotion` 위젯을 통해 부드럽게 위아래로 움직이며 사용자를 반김.
- **Text Reveal**: 문구 등장 시 `staggered fade-in` 효과를 적용하여 사용자가 자연스럽게 글을 읽어 내려갈 수 있도록 유도.
- **Interactive Feedback**: 버튼 터치 시 `Spring-based scaling` 효과로 쫀득한 조작감 제공.

---

## ⚙️ 3. 기술적 구현 계획 (Technical Implementation)

### 3.1 위젯 구조 (Widget Tree)
- `MainLayout`의 `Scaffold` 상단에 `SliverAppBar` 또는 `CustomAppBar` 배치.
- `FlexibleSpaceBar`를 활용하여 스크롤 시 헤더 영역이 자연스럽게 축소되거나 확장되도록 구현.

### 3.2 인사말 유틸리티 (Greeting Logic)
- `DateTime.now().hour`에 따라 4가지(아침, 오후, 저녁, 밤) 시간대별 인사말을 반환하는 유틸리티 클래스 구현.

### 3.3 아카이브 및 일관성 유지
- 모든 색상은 `SumpyoColors` 클래스에 정의된 상수를 사용하며, 매직 넘버 사용 금지.

---

## 🧪 4. 검증 계획 (Validation)
- **Visual Audit**: `/ui-ux-pro-max`의 체크리스트를 기반으로 텍스트 명도 대비(4.5:1 이상) 및 터치 영역(44x44 이상) 확인.
- **Performance Test**: `flutter run --profile` 모드에서 상단 애니메이션의 프레임 드랍 여부 확인.
- **User Experience**: 개편 전/후의 감성적 만족도 비교 (자체 평가 및 사용자 시뮬레이션).

---

## 🚀 5. 기대 효과 (Expected Impact)
- 사용자의 앱 체류 시간 및 호감도 상승.
- \"AI 약사\"라는 브랜드 정체성 확립.
- 따뜻하고 현대적인 디자인을 통한 앱 시장 내 차별화 성공.
