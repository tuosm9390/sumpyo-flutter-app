import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2800), () {
      if (mounted) {
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'sumpyo_mascot',
              child: Image.asset(
                'assets/sumpyo_ai_icon.png',
                width: 180,
                height: 180,
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms)
            .scale(
              begin: const Offset(0.8, 0.8), 
              end: const Offset(1.0, 1.0), 
              curve: Curves.easeOutBack
            ),
            const SizedBox(height: 32),
            Text(
              '마음의 쉼표, 숨표 AI',
              style: GoogleFonts.gowunBatang(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            )
            .animate()
            .fadeIn(delay: 400.ms, duration: 800.ms)
            .slideY(
              begin: 0.2, 
              end: 0, 
              curve: Curves.easeOutBack
            ),
          ],
        ),
      ),
    );
  }
}
