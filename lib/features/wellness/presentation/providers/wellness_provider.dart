import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/wellness_mission.dart';

part 'wellness_provider.g.dart';

class WellnessState {
  final List<WellnessMission> missions;
  final Set<String> completedHistoryDates; // 'yyyy-MM-dd' format
  final bool hasNewArrival;

  const WellnessState({
    required this.missions,
    this.completedHistoryDates = const {},
    this.hasNewArrival = false,
  });

  WellnessState copyWith({
    List<WellnessMission>? missions,
    Set<String>? completedHistoryDates,
    bool? hasNewArrival,
  }) {
    return WellnessState(
      missions: missions ?? this.missions,
      completedHistoryDates:
          completedHistoryDates ?? this.completedHistoryDates,
      hasNewArrival: hasNewArrival ?? this.hasNewArrival,
    );
  }
}

@Riverpod(keepAlive: true)
class WellnessNotifier extends _$WellnessNotifier {
  static final List<WellnessMission> _missionPool = [
    WellnessMission(
        id: '1',
        title: '3분 명상',
        description: '호흡에 집중하며 3분간 명상하기',
        category: 'Breathing',
        date: DateTime.now()),
    WellnessMission(
        id: '2',
        title: '감사 일기',
        description: '오늘 하루 감사한 일 3가지 적어보기',
        category: 'Writing',
        date: DateTime.now()),
    WellnessMission(
        id: '3',
        title: '천천히 걷기',
        description: '5분간 주변 풍경을 감상하며 걷기',
        category: 'Action',
        date: DateTime.now()),
    WellnessMission(
        id: '4',
        title: '물 한 잔 마시기',
        description: '시원한 물 한 잔으로 몸 깨우기',
        category: 'Action',
        date: DateTime.now()),
    WellnessMission(
        id: '5',
        title: '하늘 바라보기',
        description: '30초 동안 가만히 하늘 바라보기',
        category: 'Observation',
        date: DateTime.now()),
    WellnessMission(
        id: '6',
        title: '손목 스트레칭',
        description: '컴퓨터/스마트폰 작업 중 1분 스트레칭',
        category: 'Action',
        date: DateTime.now()),
    WellnessMission(
        id: '7',
        title: '좋아하는 노래 듣기',
        description: '좋아하는 노래 한 곡에 온전히 집중하기',
        category: 'Relaxation',
        date: DateTime.now()),
    WellnessMission(
        id: '8',
        title: '디지털 디톡스',
        description: '10분 동안 스마트폰 멀리하기',
        category: 'Action',
        date: DateTime.now()),
    WellnessMission(
        id: '9',
        title: '긍정 확언',
        description: '오늘 하루도 충분히 잘하고 있다 3번 말하기',
        category: 'Speaking',
        date: DateTime.now()),
    WellnessMission(
        id: '11',
        title: '두 페이지 독서',
        description: '인지 자극을 위해 책 두 페이지만 천천히 읽어보기',
        category: 'Cognitive',
        date: DateTime.now()),
    WellnessMission(
        id: '12',
        title: '팩트 체크',
        description: '스트레스 상황에서 내 감정과 객관적인 사실을 구분해보기',
        category: 'Mental',
        date: DateTime.now()),
    WellnessMission(
        id: '13',
        title: '작은 친절',
        description: '주변 사람에게 짧은 감사나 응원의 메시지 보내기',
        category: 'Social',
        date: DateTime.now()),
    WellnessMission(
        id: '14',
        title: '문틀 호흡',
        description: '문틀을 지날 때마다 의식적으로 깊은 호흡 한 번 하기',
        category: 'Breathing',
        date: DateTime.now()),
    WellnessMission(
        id: '15',
        title: '감정 명명',
        description: '현재 내 기분을 구체적인 감정 단어로 정의해보기',
        category: 'Emotional',
        date: DateTime.now()),
    WellnessMission(
        id: '16',
        title: '아침 햇살 쬐기',
        description: '생체 리듬 조절을 위해 5분간 아침 햇살 받기',
        category: 'Observation',
        date: DateTime.now()),
    WellnessMission(
        id: '17',
        title: '수면 루틴',
        description: '자기 전 조명을 낮추고 화면 기기를 멀리하며 휴식하기',
        category: 'Relaxation',
        date: DateTime.now()),
    WellnessMission(
        id: '18',
        title: '틈새 스쿼트',
        description: '무언가를 기다리는 짧은 시간 동안 스쿼트 5회 하기',
        category: 'Action',
        date: DateTime.now()),
    WellnessMission(
        id: '19',
        title: '1분 환기',
        description: '창문을 열어 실내 공기를 신선하게 바꾸고 호흡하기',
        category: 'Environment',
        date: DateTime.now()),
    WellnessMission(
        id: '20',
        title: '물건 하나 정리',
        description: '책상 위나 주변 물건 하나를 제자리에 정리하기',
        category: 'Environment',
        date: DateTime.now()),
  ];

  @override
  FutureOr<WellnessState> build() async {
    return _loadData();
  }

  DateTime getLogicalToday() {
    final now = DateTime.now();
    return now.subtract(const Duration(hours: 6));
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/wellness_data_v2.json');
  }

  Future<WellnessState> _loadData() async {
    try {
      final file = await _getLocalFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        if (content.isNotEmpty) {
          final Map<String, dynamic> data = json.decode(content);

          final List<dynamic> jsonList =
              data['missions'] as List<dynamic>? ?? [];
          final List<dynamic> historyList =
              data['history'] as List<dynamic>? ?? [];
          final String? lastNotifiedDate = data['lastNotifiedDate'] as String?;

          final loadedMissions = jsonList
              .map((json) =>
                  WellnessMission.fromJson(json as Map<String, dynamic>))
              .toList();

          final historyDates = historyList.map((e) => e.toString()).toSet();

          final logicalToday = getLogicalToday();
          final todayStr = _formatDate(logicalToday);

          if (loadedMissions.isNotEmpty) {
            final firstMissionDate = loadedMissions.first.date;

            // 날짜가 바뀌었는지 확인
            if (_formatDate(firstMissionDate) != todayStr) {
              return _generateDailyMissions(historyDates, save: false);
            }

            return WellnessState(
              missions: loadedMissions,
              completedHistoryDates: historyDates,
              hasNewArrival: lastNotifiedDate != todayStr,
            );
          }
        }
      }
      return _generateDailyMissions({}, save: true);
    } catch (e) {
      return _generateDailyMissions({}, save: true);
    }
  }

  WellnessState _generateDailyMissions(Set<String> history, {required bool save}) {
    final logicalToday = getLogicalToday();
    final seed =
        logicalToday.year * 10000 + logicalToday.month * 100 + logicalToday.day;
    final random = Random(seed);

    final poolCopy = List<WellnessMission>.from(_missionPool);
    for (int i = poolCopy.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      final temp = poolCopy[i];
      poolCopy[i] = poolCopy[j];
      poolCopy[j] = temp;
    }

    final selectedMissions = poolCopy.take(3).map((m) {
      return m.copyWith(
        date: logicalToday,
        isCompleted: false,
      );
    }).toList();

    final newState = WellnessState(
      missions: selectedMissions,
      completedHistoryDates: history,
      hasNewArrival: true,
    );
    
    if (save) {
      // 비동기로 저장 (현재 빌드 중이 아님을 보장할 수 있는 위치에서 호출 필요)
      Future.microtask(() => _saveStateData(newState));
    }
    
    return newState;
  }

  Future<void> _saveStateData(WellnessState targetState) async {
    try {
      final file = await _getLocalFile();
      final logicalToday = getLogicalToday();
      final todayStr = _formatDate(logicalToday);

      final Map<String, dynamic> data = {
        'missions': targetState.missions.map((m) => m.toJson()).toList(),
        'history': targetState.completedHistoryDates.toList(),
        'lastNotifiedDate': targetState.hasNewArrival ? '' : todayStr,
      };
      await file.writeAsString(json.encode(data));
    } catch (e) {
      // Error
    }
  }

  void markAsNotified() {
    if (state.hasValue) {
      state = AsyncValue.data(state.value!.copyWith(hasNewArrival: false));
      _saveStateData(state.value!);
    }
  }

  void toggleMission(String id) {
    if (!state.hasValue) return;
    
    final currentState = state.value!;
    final updatedMissions = [
      for (final mission in currentState.missions)
        if (mission.id == id)
          mission.copyWith(isCompleted: !mission.isCompleted)
        else
          mission,
    ];

    final isAnyCompleted = updatedMissions.any((m) => m.isCompleted);
    final todayStr = _formatDate(getLogicalToday());

    final newHistory = Set<String>.from(currentState.completedHistoryDates);
    if (isAnyCompleted) {
      newHistory.add(todayStr);
    } else {
      newHistory.remove(todayStr);
    }

    final newState = currentState.copyWith(
      missions: updatedMissions,
      completedHistoryDates: newHistory,
    );
    
    state = AsyncValue.data(newState);
    _saveStateData(newState);
  }
}
