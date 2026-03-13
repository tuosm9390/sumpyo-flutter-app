import 'package:flutter/material.dart';
import '../../core/theme/sumpyo_colors.dart';
import 'bounce_tappable.dart';

class SumpyoCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const SumpyoCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24.0),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    Widget cardContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF383838) : SumpyoColors.warmWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white10 : SumpyoColors.paperBorder,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : const Color(0x22B7C9B0),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      return BounceTappable(
        onTap: onTap!,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
