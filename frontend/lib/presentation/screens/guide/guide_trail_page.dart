// ✅ Guide Trail Page (same as tourist but with "Guide" button)
import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/bottom_nav.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/guide_bottom_nav.dart';

class GuideTrailPage extends StatelessWidget {
  final String title;
  const GuideTrailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                color: Colors.grey.shade300,
              ),
              title: Text("Trail Spot ${index + 1}"),
            ),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () => context.go("/upload"),
        child: const Text("Guide"),
      ),
    );
  }
}
