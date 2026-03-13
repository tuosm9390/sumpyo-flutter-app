import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../providers/prescription_provider.dart';
import '../widgets/emotion_chart_widget.dart';
import '../widgets/sumpyo_app_bar.dart';
import '../../data/models/prescription_model.dart';
import '../../domain/entities/prescription.dart';
import '../../../../shared/widgets/sumpyo_card.dart';
import '../../../../shared/widgets/sumpyo_button.dart';
import '../../../../shared/widgets/sumpyo_loading.dart';
import '../../../../shared/widgets/prescription_share_card.dart';
import '../../../../core/theme/sumpyo_colors.dart';
import '../../../../core/utils/string_utils.dart';

class PrescriptionsPage extends ConsumerWidget {
  const PrescriptionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptionsAsync = ref.watch(prescriptionNotifierProvider);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          color: SumpyoColors.muteBlue.withValues(alpha: 0.1),
          child: prescriptionsAsync.when(
            data: (prescriptions) {
              if (prescriptions.isEmpty) {
                return CustomScrollView(
                  slivers: [
                    const SumpyoAppBar(),
                    SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 64,
                              color: SumpyoColors.softCharcoal
                                  .withValues(alpha: 0.2),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              StringUtils.keepAll('아직 조제된 처방전이 없습니다.'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: SumpyoColors.softCharcoal
                                        .withValues(alpha: 0.5),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              final models = prescriptions
                  .map((e) => PrescriptionModel.fromEntity(e))
                  .toList();

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SumpyoAppBar(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 24, left: 24, right: 24, bottom: 16),
                      child: EmotionChartWidget(prescriptions: models)
                          .animate()
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: 0.1, end: 0),
                    ),
                  ),
                  SliverPadding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, bottom: 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final p =
                              prescriptions[prescriptions.length - 1 - index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: SumpyoCard(
                              onTap: () {
                                _showPrescriptionDialog(context, p);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: SumpyoColors.sageGreen
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        StringUtils.keepAll(p.style == 'F'
                                            ? '공감 위로'
                                            : (p.style == 'T'
                                                ? '이성 조언'
                                                : '따뜻한 온기')),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: SumpyoColors.sageGreen,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    StringUtils.keepAll(p.title),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(fontSize: 20),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    StringUtils.keepAll(p.quote),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nanumPenScript(
                                      fontSize: 18,
                                      color: SumpyoColors.softCharcoal
                                          .withValues(alpha: 0.8),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                                .animate()
                                .fadeIn(
                                    duration: 400.ms, delay: (index * 50).ms)
                                .slideX(begin: 0.1, end: 0),
                          );
                        },
                        childCount: prescriptions.length,
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: SumpyoLoadingIndicator(),
            ),
            error: (err, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  StringUtils.keepAll('오류가 발생했습니다:\n$err'),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showPrescriptionDialog(BuildContext context, Prescription p) {
    final GlobalKey boundaryKey = GlobalKey();

    final String formattedContent = p.content.replaceAll('. ', '.\n\n');
    final String formattedQuote = p.quote;

    Future<String?> captureImage() async {
      try {
        final boundary = boundaryKey.currentContext?.findRenderObject()
            as RenderRepaintBoundary?;
        if (boundary == null) return null;

        final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        final ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData == null) return null;

        final Uint8List pngBytes = byteData.buffer.asUint8List();

        final directory = await getTemporaryDirectory();
        final String fileName =
            'sumpyo_prescription_${DateTime.now().millisecondsSinceEpoch}.png';
        final File imageFile = File('${directory.path}/$fileName');
        await imageFile.writeAsBytes(pngBytes);
        return imageFile.path;
      } catch (e) {
        if (kDebugMode) {
          print('Error capturing prescription image: $e');
        }
        return null;
      }
    }

    Future<void> handleShare() async {
      final String? imagePath = await captureImage();
      if (imagePath != null && context.mounted) {
        _showSharePreview(context, imagePath, p);
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: SumpyoColors.warmWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
        child: Stack(
          children: [
            Positioned(
              left: -1000,
              child: RepaintBoundary(
                key: boundaryKey,
                child: SizedBox(
                  width: 360,
                  child: PrescriptionShareCard(prescription: p),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: SumpyoColors.softCharcoal.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        StringUtils.keepAll(p.title),
                        style: Theme.of(context).textTheme.displayMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: handleShare,
                      icon: const Icon(Icons.share_outlined),
                      color: SumpyoColors.sageGreen,
                      tooltip: StringUtils.keepAll('공유하기'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color:
                                SumpyoColors.muteBlue.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            StringUtils.keepAll(formattedQuote),
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: GoogleFonts.nanumPenScript(
                              fontSize: 24,
                              height: 1.4,
                              color: SumpyoColors.softCharcoal
                                  .withValues(alpha: 0.9),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          StringUtils.keepAll(formattedContent),
                          softWrap: true,
                          textAlign: TextAlign.left,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    height: 1.8,
                                    letterSpacing: 0.2,
                                    color: SumpyoColors.softCharcoal,
                                  ),
                        ),
                        const SizedBox(height: 48),
                        const Divider(height: 1, thickness: 0.5),
                        const SizedBox(height: 24),
                        Text(
                          StringUtils.keepAll('내가 들려준 이야기'),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: SumpyoColors.softCharcoal
                                        .withValues(alpha: 0.5),
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          StringUtils.keepAll(p.emotion),
                          softWrap: true,
                          textAlign: TextAlign.left,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: SumpyoColors.softCharcoal
                                        .withValues(alpha: 0.6),
                                    height: 1.6,
                                  ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: SumpyoButton(
                        text: StringUtils.keepAll('공유하기'),
                        onPressed: handleShare,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SumpyoButton(
                        text: StringUtils.keepAll('닫기'),
                        isSecondary: true,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSharePreview(
      BuildContext context, String imagePath, Prescription p) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Container(
          decoration: BoxDecoration(
            color: SumpyoColors.warmWhite,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringUtils.keepAll('이미지 미리보기'),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: SumpyoColors.softCharcoal,
                    ),
              ),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SumpyoButton(
                text: StringUtils.keepAll('공유하기'),
                onPressed: () async {
                  // ignore: deprecated_member_use
                  await Share.shareXFiles(
                    [XFile(imagePath)],
                    text: '숨표 AI가 전하는 따뜻한 처방전: ${p.title}',
                  );
                  if (context.mounted) Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
              SumpyoButton(
                text: StringUtils.keepAll('취소'),
                isSecondary: true,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 300.ms).scale(
              begin: const Offset(0.9, 0.9),
              end: const Offset(1, 1),
              curve: Curves.easeOutBack,
            ),
      ),
    );
  }
}
