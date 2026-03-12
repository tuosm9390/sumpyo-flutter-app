import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../features/home/domain/entities/prescription.dart';
import '../../core/theme/sumpyo_colors.dart';

class PrescriptionShareCard extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionShareCard({
    super.key,
    required this.prescription,
  });

  @override
  Widget build(BuildContext context) {
    // Background color based on style
    final Color backgroundColor;
    switch (prescription.style) {
      case 'F':
        backgroundColor = const Color(0xFFFFF0F0); // Pastel Pink/Peach
        break;
      case 'T':
        backgroundColor = const Color(0xFFF0F8FF); // Pastel Blue
        break;
      case 'W':
        backgroundColor = const Color(0xFFFFFDF0); // Pastel Yellow/Cream
        break;
      default:
        backgroundColor = SumpyoColors.warmWhite;
    }

    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                _keepAll(prescription.title),
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSansKr(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  color: SumpyoColors.softCharcoal,
                ),
              ),
              const SizedBox(height: 32),

              // Quote
              Text(
                _keepAll(prescription.quote),
                textAlign: TextAlign.center,
                style: GoogleFonts.nanumPenScript(
                  fontSize: 28,
                  height: 1.4,
                  color: SumpyoColors.softCharcoal.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Word-break (keep-all) helper for Korean
  String _keepAll(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word.split('').join('\u200D');
    }).join(' ');
  }
}

