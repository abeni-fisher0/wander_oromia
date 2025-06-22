// ✅ Saved Trails Page (same as tourist)
import 'package:flutter/material.dart';
import '../../widgets/bottom_nav.dart';

class SavedTrailsPage extends StatelessWidget {
  const SavedTrailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Trails')),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: const [
          _SavedTrailCard("Irreecha", "festival"),
          _SavedTrailCard("Coffee Trail", "foods and cuisine"),
          _SavedTrailCard("Bale mountain", "wildlife conservation"),
          _SavedTrailCard("Sof omar cave", "lakes and craters"),
        ],
      ),
    );
  }
}

class _SavedTrailCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SavedTrailCard(this.title, this.subtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(width: 50, height: 50, color: Colors.grey),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {},
      ),
    );
  }
}
