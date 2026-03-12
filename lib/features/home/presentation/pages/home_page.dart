import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/prescription_provider.dart';
import '../widgets/sumpyo_app_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/prescription_completion_dialog.dart';
import '../../../../shared/widgets/sumpyo_button.dart';
import '../../../../shared/widgets/bounce_tappable.dart';
import '../../../../core/theme/sumpyo_colors.dart';
import '../../../../core/utils/string_utils.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _controller = TextEditingController();
  String _selectedStyle = 'F';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prescriptionsAsync = ref.watch(prescriptionNotifierProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SumpyoAppBar(),
            const HeroSection(),
            SliverPadding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      style: theme.textTheme.bodyLarge,
                      decoration: InputDecoration(
                        hintText: StringUtils.keepAll('당신의 오늘 하루를 알려주세요'),
                        filled: true,
                        fillColor: isDark ? const Color(0xFF383838) : Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: SumpyoColors.sageGreen, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                      ),
                      maxLines: 6,
                    ),
                  ).animate().fadeIn(delay: 600.ms, duration: 600.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 32),
                  Text(
                    StringUtils.keepAll('어떤 처방을 원하시나요?'),
                    style: theme.textTheme.displaySmall?.copyWith(fontSize: 18),
                  ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _styleButton(context, '공감형', 'F')),
                      const SizedBox(width: 12),
                      Expanded(child: _styleButton(context, '이성형', 'T')),
                      const SizedBox(width: 12),
                      Expanded(child: _styleButton(context, '온기형', 'W')),
                    ],
                  ).animate().fadeIn(delay: 1000.ms, duration: 600.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: Text(
                        _selectedStyle == 'F'
                            ? StringUtils.keepAll('당신의 감정에 깊이 공감하며 마음을 어루만져 드립니다.')
                            : _selectedStyle == 'T'
                                ? StringUtils.keepAll('차분하고 논리적인 분석으로 문제 해결의 실마리를 찾습니다.')
                                : StringUtils.keepAll('따뜻한 햇살처럼 포근하고 다정한 위로를 전합니다.'),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ).animate().fadeIn(delay: 1100.ms, duration: 400.ms),
                  const SizedBox(height: 48),
                  SumpyoButton(
                    text: StringUtils.keepAll('처방전 조제하기'),
                    onPressed: () async {
                      if (_controller.text.isNotEmpty) {
                        final prompt = _controller.text;
                        final style = _selectedStyle;
                        _controller.clear();
                        FocusScope.of(context).unfocus();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(StringUtils.keepAll('처방전을 조제 중입니다. 잠시만 기다려주세요!')),
                            backgroundColor: SumpyoColors.sageGreen,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            duration: const Duration(seconds: 3),
                          ),
                        );

                        final prescription = await ref.read(prescriptionNotifierProvider.notifier).generatePrescription(
                          prompt,
                          style,
                        );

                        if (prescription != null && mounted) {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) => PrescriptionCompletionDialog(prescription: prescription),
                          );
                        }
                      }
                    },
                    isLoading: prescriptionsAsync.isLoading,
                  ).animate().fadeIn(delay: 1200.ms, duration: 600.ms),
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _styleButton(BuildContext context, String label, String code) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isSelected = _selectedStyle == code;

    return BounceTappable(
      onTap: () {
        setState(() {
          _selectedStyle = code;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
            ? SumpyoColors.sageGreen
            : (isDark ? const Color(0xFF383838) : Colors.white),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? SumpyoColors.sageGreen : SumpyoColors.sageGreen.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: SumpyoColors.sageGreen.withValues(alpha: 0.2), blurRadius: 12, offset: const Offset(0, 6))]
              : [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        alignment: Alignment.center,
        child: Text(
          StringUtils.keepAll(label),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isSelected ? Colors.white : theme.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

