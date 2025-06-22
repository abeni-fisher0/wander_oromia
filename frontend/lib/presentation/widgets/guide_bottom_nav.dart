// lib/presentation/widgets/guide_bottom_nav.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GuideBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const GuideBottomNavBar({Key? key, required this.currentIndex})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/guidehome');
            break;
          case 1:
            context.go('/upload');
            break;
          case 2:
            context.go('/guidesaved');
            break;
          case 3:
            context.go('/guide-profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.upload_file), label: 'Upload'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
