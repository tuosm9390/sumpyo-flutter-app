import 'string_utils.dart';

class GreetingUtils {
  /// 사용자의 위치 기반 일출/일몰 시간을 고려하여 4단계 인사말을 반환합니다.
  /// 일출 이후 -> 아침 / 12시 이후 -> 점심 / 일몰 이후 -> 저녁
  static String getGreeting({DateTime? now, DateTime? sunrise, DateTime? sunset}) {
    final t = now ?? DateTime.now();
    final baseDate = DateTime(t.year, t.month, t.day);
    
    // 기본값 설정
    final effectiveSunrise = sunrise ?? baseDate.add(const Duration(hours: 6));
    final noon = baseDate.add(const Duration(hours: 12));
    final effectiveSunset = sunset ?? baseDate.add(const Duration(hours: 18));

    if (t.isBefore(effectiveSunrise)) {
      return StringUtils.keepAll('고요한 새벽이네요.\n당신의 밤이 평온한 쉼표가 되길 바라요.');
    } else if (t.isBefore(noon)) {
      return StringUtils.keepAll('좋은 아침이에요.\n오늘 당신의 마음은 어떤 색인가요?');
    } else if (t.isBefore(effectiveSunset)) {
      return StringUtils.keepAll('따뜻한 햇살 아래 점심 시간,\n잠시 숨을 고르며 차 한 잔 어떠신가요?');
    } else {
      return StringUtils.keepAll('노을이 지는 저녁이네요.\n오늘 하루도 정말 고생 많으셨어요.');
    }
  }

  static String getSubGreeting({DateTime? now, DateTime? sunrise, DateTime? sunset}) {
    final t = now ?? DateTime.now();
    final baseDate = DateTime(t.year, t.month, t.day);
    
    final effectiveSunrise = sunrise ?? baseDate.add(const Duration(hours: 6));
    final noon = baseDate.add(const Duration(hours: 12));
    final effectiveSunset = sunset ?? baseDate.add(const Duration(hours: 18));

    if (t.isBefore(effectiveSunrise)) {
      return StringUtils.keepAll('깊은 밤, 숨표가 당신의 곁을 지키고 있어요.');
    } else if (t.isBefore(noon)) {
      return StringUtils.keepAll('새로운 하루의 시작을 숨표가 함께할게요.');
    } else if (t.isBefore(effectiveSunset)) {
      return StringUtils.keepAll('나른한 오후, 마음의 쉼표가 필요한 시간.');
    } else {
      return StringUtils.keepAll('오늘의 조각들을 하나씩 정리해 볼까요?');
    }
  }
}
