# 🧘 웰니스 루틴 기능 구현 계획 (Wellness Routine)

## Goal
사용자가 매일 마음 챙김을 실천할 수 있도록 오늘의 미션과 달성도를 트래킹하는 기능을 구현합니다.

## Tasks
- [x] Task 1: `lib/features/wellness/domain/entities/wellness_mission.dart` 생성 (엔티티 정의) -> Verify: 파일 생성 확인
- [x] Task 2: `lib/features/wellness/presentation/providers/wellness_provider.dart` 구현 (Riverpod 상태 관리 및 JSON 로컬 저장) -> Verify: 상태 업데이트 로직 테스트
- [x] Task 3: `lib/features/wellness/presentation/pages/wellness_page.dart` UI 기본 구조 구현 -> Verify: 화면 진입 확인
- [x] Task 4: `MissionHero` 및 `MissionList` 위젯 개발 (애니메이션 포함) -> Verify: 미션 토글 시 체크 표시 애니메이션 작동
- [x] Task 5: `WeeklyProgress` 위젯 개발 -> Verify: 지난 7일간의 달성도 시각화 확인
- [x] Task 6: `lib/features/home/presentation/pages/main_layout.dart`에 웰니스 탭 추가 -> Verify: 하단 탭 바에서 3개 메뉴 정상 작동

## Done When
- [x] 웰니스 탭에서 오늘의 미션을 확인하고 완료 처리할 수 있음.
- [x] 앱 재시작 후에도 미션 완료 상태가 유지됨.
- [x] 디자인 시스템(Warm Digital Pharmacy)에 부합하는 감성적인 UI가 표시됨.

## Notes
- `flutter_animate`를 적극 활용하여 미션 완료 시 성취감을 느낄 수 있는 피드백을 제공합니다.
- 추후 Phase 9에서 Hive로 마이그레이션할 예정이므로, 현재는 JSON 파일 기반으로 최소한의 지속성을 확보합니다.

