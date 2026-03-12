import "dart:io";
import "package:flutter_test/flutter_test.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive/hive.dart";
import "package:sumpyo_app/main.dart";

void main() {
  final tempDir = Directory.systemTemp.createTempSync();

  setUpAll(() {
    Hive.init(tempDir.path);
  });

  tearDownAll(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  testWidgets("숨표 앱 스모크 테스트", (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    expect(find.byType(MyApp), findsOneWidget);
  });
}
