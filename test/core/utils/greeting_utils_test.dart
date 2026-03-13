import 'package:flutter_test/flutter_test.dart';
import 'package:sumpyo_app/core/utils/greeting_utils.dart';

void main() {
  group('GreetingUtils 4-Stage Tests', () {
    String clean(String text) => text.replaceAll('\u200D', '');

    test('1. 새벽 (Dawn): Should show dawn greeting at 3 AM', () {
      final dawnTime = DateTime(2026, 3, 13, 3, 0, 0);
      final greeting = clean(GreetingUtils.getGreeting(now: dawnTime));
      expect(greeting.contains('고요한 새벽'), isTrue);
    });

    test('2. 아침 (Morning): Should show morning greeting at 8 AM', () {
      final morningTime = DateTime(2026, 3, 13, 8, 0, 0);
      final greeting = clean(GreetingUtils.getGreeting(now: morningTime));
      expect(greeting.contains('좋은 아침'), isTrue);
    });

    test('3. 점심 (Lunch): Should show lunch greeting at 1 PM (13:00)', () {
      final lunchTime = DateTime(2026, 3, 13, 13, 0, 0);
      final greeting = clean(GreetingUtils.getGreeting(now: lunchTime));
      expect(greeting.contains('점심 시간'), isTrue);
    });

    test('4. 저녁 (Evening): Should show evening greeting at 7 PM (19:00)', () {
      final eveningTime = DateTime(2026, 3, 13, 19, 0, 0);
      final greeting = clean(GreetingUtils.getGreeting(now: eveningTime));
      expect(greeting.contains('저녁이네요'), isTrue);
    });

    test('Dynamic: Should adapt to actual sunrise/sunset API data', () {
      // 겨울이라 해가 늦게 뜨는 상황 가정 (오전 7시 30분 일출)
      final winterSunrise = DateTime(2026, 1, 1, 7, 30);
      
      // 오전 7시는 원래 '아침'이지만, 일출 전이므로 '새벽' 문구가 나와야 함
      final sevenAM = DateTime(2026, 1, 1, 7, 0);
      
      final greeting = clean(GreetingUtils.getGreeting(
        now: sevenAM, 
        sunrise: winterSunrise
      ));
      
      expect(greeting.contains('고요한 새벽'), isTrue);
    });
  });
}
