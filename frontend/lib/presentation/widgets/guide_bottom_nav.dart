// bottom_nav.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// BottomNavBar used by all pages
class GuideBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const GuideBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: const Color(0xFF145A32), // ✅ dark green background
      selectedItemColor: Colors.white, // ✅ white icon (selected)
      unselectedItemColor: Colors.white, // ✅ white icon (unselected)
      type: BottomNavigationBarType.fixed, // ✅ prevents shifting behavior
      onTap: (index) {
        switch (index) {
          case 0:
            GoRouter.of(context).go('/guidehome');
            break;
          case 1:
            GoRouter.of(context).go('/guidesaved');
            break;
          case 2:
            GoRouter.of(context).go('/guideprofile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
    );
  }
}
