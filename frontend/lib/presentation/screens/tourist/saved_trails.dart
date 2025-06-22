// saved_trails_page.dart
import 'package:flutter/material.dart';
import '../../widgets/bottom_nav.dart';

class SavedTrailsPage extends StatelessWidget {
  const SavedTrailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> savedTrails = [
      {'title': 'Irrecha', 'category': 'festival'},
      {'title': 'Coffee Trail', 'category': 'foods and cuisine'},
      {'title': 'Bale Mountain', 'category': 'wildlife conservation'},
      {'title': 'Sof Omer Cave', 'category': 'lakes and craters'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Trails'),
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset('assets/images/flag.png', height: 24),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: savedTrails.length,
        itemBuilder: (context, index) {
          final trail = savedTrails[index];
          return Card(
            color: Colors.green.shade50,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Container(
                height: 40,
                width: 40,
                color: Colors.grey.shade300,
              ),
              title: Text(trail['title'] ?? ''),
              subtitle: Text(trail['category'] ?? ''),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
