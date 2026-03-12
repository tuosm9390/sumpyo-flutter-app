import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/router/router.dart';
import 'core/theme/sumpyo_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 환경 변수 초기화 (.env)
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    debugPrint('Dotenv load error: $e');
  }

  // Hive 초기화
  await Hive.initFlutter();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '마음 약방',
      debugShowCheckedModeBanner: false,
      theme: SumpyoTheme.lightTheme,
      routerConfig: router,
    );
  }
}
