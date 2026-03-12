import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/wellness_mission.dart';

part 'wellness_provider.g.dart';

@riverpod
class WellnessNotifier extends _$WellnessNotifier {
  @override
  List<WellnessMission> build() {
    _loadMissions();
    return [];
  }

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/wellness_data.json');
  }

  Future<void> _loadMissions() async {
    try {
      final file = await _getLocalFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        if (content.isNotEmpty) {
          final List<dynamic> jsonList = json.decode(content);
          if (jsonList.isNotEmpty) {
            state = jsonList.map((json) => WellnessMission.fromJson(json as Map<String, dynamic>)).toList();
            return;
          }
        }
      }
      _initializeDefaults();
    } catch (e) {
      _initializeDefaults();
    }
  }

  void _initializeDefaults() {
    final now = DateTime.now();
    final defaults = [
      WellnessMission(
        id: '1',
        title: '3분 명상',
        description: '호흡에 집중하며 3분간 명상하기',
        category: 'Breathing',
        date: now,
      ),
      WellnessMission(
        id: '2',
        title: '감사 일기',
        description: '오늘 하루 감사한 일 3가지 적어보기',
        category: 'Writing',
        date: now,
      ),
      WellnessMission(
        id: '3',
        title: '천천히 걷기',
        description: '5분간 주변 풍경을 감상하며 걷기',
        category: 'Action',
        date: now,
      ),
      WellnessMission(
        id: '4',
        title: '물 한 잔 마시기',
        description: '시원한 물 한 잔으로 몸 깨우기',
        category: 'Action',
        date: now,
      ),
      WellnessMission(
        id: '5',
        title: '하늘 바라보기',
        description: '30초 동안 가만히 하늘 바라보기',
        category: 'Observation',
        date: now,
      ),
      WellnessMission(
        id: '6',
        title: '손목 스트레칭',
        description: '컴퓨터/스마트폰 작업 중 1분 스트레칭',
        category: 'Action',
        date: now,
      ),
      WellnessMission(
        id: '7',
        title: '좋아하는 노래 듣기',
        description: '좋아하는 노래 한 곡에 온전히 집중하기',
        category: 'Relaxation',
        date: now,
      ),
      WellnessMission(
        id: '8',
        title: '디지털 디톡스',
        description: '10분 동안 스마트폰 멀리하기',
        category: 'Action',
        date: now,
      ),
      WellnessMission(
        id: '9',
        title: '긍정 확언',
        description: '오늘 하루도 충분히 잘하고 있다 3번 말하기',
        category: 'Speaking',
        date: now,
      ),
    ];
    state = defaults;
    _saveMissions();
  }

  Future<void> _saveMissions() async {
    try {
      final file = await _getLocalFile();
      final jsonList = state.map((m) => m.toJson()).toList();
      await file.writeAsString(json.encode(jsonList));
    } catch (e) {
      // Handle error or log
    }
  }

  void toggleMission(String id) {
    state = [
      for (final mission in state)
        if (mission.id == id)
          mission.copyWith(isCompleted: !mission.isCompleted)
        else
          mission,
    ];
    _saveMissions();
  }
}