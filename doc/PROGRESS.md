Date: 2026-03-12
Author: Antigravity

# 📈 프로젝트 진행 상황 (Project Progress)
현재 **마음 약방 (구 숨표 AI)** 앱의 개발 진행 현황을 트래킹하는 문서입니다.

## 🚀 전체 로드맵 현황

### [완료 ✅] Phase 1 ~ 3: UI/UX 기반 구축 및 핵심 뷰 구현
- **앱 타이틀 변경**: 숨표 AI -> 마음 약방
- **테마 및 컬러 시스템 구축**: 순백색 대신 Warm White, 메인 포인트 Sage Green, 텍스트 Soft Charcoal 적용.
- **시그니처 애니메이션 위젯 개발**:
  - BounceTappable: 스프링 물리 엔진 기반의 터치 피드백 (햅틱 포함)
  - FloatingMotion: 심야의 고요함을 나타내는 상시 둥둥 떠다니는 애니메이션
  - BouncingMotion: 약을 조제하는 듯한 귀여운 로딩 인디케이터
- **화면 분리 및 네비게이션**:
  - MainLayout (하단 탭 바) 추가: '마음 약방' 폼 화면과 '내 처방전' 목록 화면을 분리.
- **코드 품질 최적화**: Dart Analyzer 기준 withOpacity 폐기 경고 수정, Riverpod 타입 정리 완벽 적용 (0 Issues).

### [완료 ✅] Phase 4: 임시 데이터 파이프라인 구축 (Local Mock Data)
- **로컬 스토리지 연동**: path_provider와 dart:io를 사용하여 사용자 기기 내부의 data.json 파일에 처방전 데이터 읽기/쓰기 구현.
- **모의 API 응답**: 네트워크 대기 시간(Future.delayed)을 적용하고, 선택한 처방 스타일(F/T/W)에 따른 조건부 가짜 데이터 응답 구현.

### [완료 ✅] Phase 5: 리텐션 및 디테일 고도화 (Polish & Retention)
- **감정 분석 차트**: fl_chart 패키지를 연동하여 '내 처방전' 상단에 사용자가 선택했던 위로 방식(F/T/W) 비율을 도넛 차트(PieChart)로 시각화.
- **리스트 고도화**: CustomScrollView 및 Sliver 패턴을 적용하여 차트와 처방전 히스토리 리스트가 자연스럽게 함께 스크롤되도록 개선. 최신순 정렬 적용.

### [완료 ✅] Phase 6: AI 엔진 고도화 및 시스템 통합 (Intelligence & Integration)
- **전문 상담 기법 통합**: AI 조제 로직에 심리학적 프레임워크 전격 도입.
  - 칼 로저스(공감형), CBT(이성형), 서사 치료(온기형) 기법을 스타일별로 정밀하게 튜닝.
  - NVC(비폭력 대화) 구조(관찰-느낌-필요-요청)를 프롬프트에 강제하여 답변의 논리적 깊이 확보.
- **Gemini API 연동**: google_generative_ai를 통한 실제 AI 호출 및 JSON 모드 적용.
- **데이터 엔티티 확장**: Prescription 엔티티에 emotion 필드를 추가하여 사용자가 작성한 원래 고민 내용을 처방전과 함께 영구 보관하도록 개선.
- **처방전 UI 리뉴얼**:
  - Nanum Pen Script 캘리그라피 폰트 적용으로 감성적인 처방전 무드 완성.
  - 문장 단위 자동 줄바꿈(\n\n) 로직 구현으로 가독성 극대화.
  - 최하단에 사용자 입력 원문을 연하게 표시하여 개인화된 경험 제공.

### [완료 ✅] Phase 7: 시각적 정교화 및 UX 폴리싱 (Visual Refinement & UX Polish)
- **인트로 화면 (IntroPage)**: 중앙에 배치된 마스코트와 애니메이션이 적용된 인사말 구현.
- **동적 인사말 시스템**: 시간대에 따라 변하는 인사말 로직 구축 (GreetingUtils).
- **홈 화면 UI 개편**: CustomAppBar, HeroSection 통합으로 "따스한 햇살 아래, 당신의 쉼표" 디자인 테마 완성.
- **스크롤 인터랙션**: SliverAppBar와 CustomScrollView를 활용하여 스크롤에 따른 자연스러운 레이아웃 변화 구현.
- **풀 다크 모드 지원**: 홈 화면 전반에 걸친 다크 모드 테마 완벽 대응.
- **UI 일관성 확보**: PrescriptionsPage의 중복 AppBar를 제거하여 MainLayout과의 시각적 조화 개선.

### [완료 ✅] Phase 8: 고급 기능 확장 - 소셜 공유 & 웰니스 (Advanced Features)
- **9:16 인스타그램 스토리 최적화**: 인스타그램 공유에 최적화된 전용 카드 위젯(PrescriptionShareCard) 개발.
- **데일리 마음 챙김 미션**: 명상, 일기, 산책 등 9가지 데일리 미션 시스템 구축.
- **웰니스 데이터 관리**: wellness_data.json 기반의 로컬 지속성 및 Riverpod 상태 관리 구현.
- **감성적 UI/UX**: MissionHero, WeeklyProgress 등 시각적 달성도 위젯 개발 및 웰니스 탭 레이아웃 완성.

### [진행 중 ⏳] Phase 9: 인프라 안정화 및 클라우드 동기화 (Infra & Sync)
1. **Hive 전환**: 기존 JSON 파일 기반 저장소를 고성능 Hive NoSQL DB로 마이그레이션 (Planned).
2. **Supabase 연동**: 유저 익명 로그인 및 클라우드 백업 기능 구현 (In Progress).
3. **보안 강화**: API Key 보안을 위한 환경 변수(.env) 관리 및 RLS 정책 수립.

---

## ⏳ 다음 진행 단계

### [계획] Phase 10: 통계 리포트 및 성능 최적화 (Statistics & Optimization)
- **감정 추세 분석**: 주간/월간 단위의 감정 변화를 선형 그래프로 시각화 (fl_chart).
- **키워드 분석**: 대화 내용에서 자주 언급된 감정 키워드 추출 및 요약.
- **네이티브 성능 최적화**: 렌더링 파이프라인 점검 및 60/120fps 고정 타겟팅.
