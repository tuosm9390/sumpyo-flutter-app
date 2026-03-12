import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';
import 'prescriptions_page.dart';
import '../../../wellness/presentation/pages/wellness_page.dart';
import '../../../../core/theme/sumpyo_colors.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    WellnessPage(),
    PrescriptionsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: SumpyoColors.warmWhite,
          boxShadow: [
            BoxShadow(
              color: SumpyoColors.softCharcoal.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: Colors.transparent,
              currentIndex: _currentIndex,
              selectedItemColor: SumpyoColors.sageGreen,
              unselectedItemColor: SumpyoColors.softCharcoal.withValues(alpha: 0.4),
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Pretendard'),
              unselectedLabelStyle: const TextStyle(fontFamily: 'Pretendard'),
              onTap: (index) {
                HapticFeedback.selectionClick();
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded),
                  label: '마음 약방',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.spa_outlined),
                  activeIcon: Icon(Icons.spa_rounded),
                  label: '웰니스',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_outlined),
                  activeIcon: Icon(Icons.receipt_long_rounded),
                  label: '내 처방전',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
