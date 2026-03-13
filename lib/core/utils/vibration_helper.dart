import 'package:flutter/services.dart';

class VibrationHelper {
  /// 매우 가벼운 터치 (버튼 탭, 슬라이더 틱)
  static Future<void> selectionClick() async {
    await HapticFeedback.selectionClick();
  }

  /// 일반적인 탭 피드백 (화면 전환, 덜 중요한 액션)
  static Future<void> lightImpact() async {
    await HapticFeedback.lightImpact();
  }

  /// 중간 강도의 피드백 (카드 선택, 모달 오픈)
  static Future<void> mediumImpact() async {
    await HapticFeedback.mediumImpact();
  }

  /// 강한 피드백 (결제 완료, 처방전 도착 등 긍정적 주요 경험)
  static Future<void> heavyImpact() async {
    await HapticFeedback.heavyImpact();
  }

  /// 에러, 경고 (Error/Warning)
  static Future<void> vibrate() async {
    await HapticFeedback.vibrate();
  }
}
