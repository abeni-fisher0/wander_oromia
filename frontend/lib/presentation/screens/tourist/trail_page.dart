// trail_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/bottom_nav.dart';

class TrailPage extends StatelessWidget {
  final String title;

  const TrailPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> stops = ['Jimma', 'Arsi', 'Bale', 'Goba'];

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green, title: Text(title)),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...stops.map(
              (stop) => Card(
                child: ListTile(
                  title: Text(stop),
                  subtitle: const Text('Learn more'),
                  onTap: () => context.go('/stop/$stop'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Love this trail?'),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Save Trail'),
            ),
          ],
        ),
      ),
    );
  }
}
