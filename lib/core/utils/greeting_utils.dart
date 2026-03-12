import 'string_utils.dart';

class GreetingUtils {
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return StringUtils.keepAll('좋은 아침이에요.\n오늘 당신의 마음은 어떤 색인가요?');
    } else if (hour >= 12 && hour < 17) {
      return StringUtils.keepAll('잠시 쉬어가도 괜찮아요.\n따뜻한 차 한 잔과 함께 이야기를 들려주세요.');
    } else if (hour >= 17 && hour < 21) {
      return StringUtils.keepAll('노을이 예쁜 저녁이네요.\n오늘 하루도 정말 고생 많으셨어요.');
    } else {
      return StringUtils.keepAll('수고 많았던 오늘,\n당신의 지친 마음을 이곳에 잠시 내려놓으세요.');
    }
  }

  static String getSubGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return StringUtils.keepAll('새로운 하루의 시작을 숨표가 함께할게요.');
    } else if (hour >= 12 && hour < 17) {
      return StringUtils.keepAll('나른한 오후, 마음의 쉼표가 필요한 시간.');
    } else if (hour >= 17 && hour < 21) {
      return StringUtils.keepAll('오늘의 조각들을 하나씩 정리해 볼까요?');
    } else {
      return StringUtils.keepAll('깊은 밤, 당신의 이야기에 귀를 기울입니다.');
    }
  }
}
