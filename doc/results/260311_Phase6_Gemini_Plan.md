Date: 2026-03-11 17:00:00
Author: Antigravity

# 🚀 [260311] 마음 약방: Phase 6 Implementation Plan (Gemini API Integration)

## 📌 목표

Phase 4에서 만들어둔 모의 데이터(Mock API) 환경을 제거하고, 실제 **Google Gemini API**를 직접 호출하여 사용자의 고민을 분석하고 AI 처방전을 생성하는 로직을 구현합니다.
(Supabase 연동은 추후 진행)

## 🎯 작업 단계

### 1. 패키지 설치 [완료 ✅]

- google_generative_ai 패키지 추가 (공식 Gemini Dart SDK).

### 2. 환경 변수 및 설정 파일 (Config) [완료 ✅]

- 프로젝트 루트에 .env 파일을 생성하고 GEMINI_API_KEY를 저장합니다.
- .env를 파싱하기 위해 lutter_dotenv 패키지 추가.
- main.dart 구동 시 dotenv.load() 실행 및 .gitignore에 .env 확인.

### 3. AIRemoteDataSource 개편 [완료 ✅]

- lib/features/home/data/datasources/ai_remote_datasource.dart 수정.
- GenerativeModel을 초기화하고, generateContent 메서드를 사용하여 Gemini API 호출.
- System Instruction에 doc/AI_LOGIC.md에 정의된 페르소나 및 응답 스키마(JSON) 강제 프롬프트를 적용합니다.
- API 응답(JSON String)을 파싱하여 기존 DTO에 매핑합니다.

### 4. 에러 핸들링 [완료 ✅]

- API Rate Limit, 응답 타임아웃, JSON 파싱 에러 등을 적절히 캐치하여 폴백(Fallback) 메시지를 반환하도록 ry-catch 고도화.

### 5. 테스트 및 검증 [완료 ✅]

- 앱을 빌드하여 실제 텍스트 입력 시 정상적인 AI 응답이 생성되고 리스트에 저장되는지 확인합니다.
