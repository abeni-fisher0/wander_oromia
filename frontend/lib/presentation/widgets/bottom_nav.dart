// bottom_nav.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// BottomNavBar used by all pages
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});
  

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF145A32),     // ✅ dark green (active icon)
        unselectedItemColor: const Color(0xFF145A32),
      onTap: (index) {
        switch (index) {
          case 0:
            GoRouter.of(context).go('/home');
            break;
          case 1:
            GoRouter.of(context).go('/saved');
            break;
          case 4:
            GoRouter.of(context).go('/culture');
            break;
          case 5:
            GoRouter.of(context).go('/tourist-profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.terrain), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
    );
  }
}
