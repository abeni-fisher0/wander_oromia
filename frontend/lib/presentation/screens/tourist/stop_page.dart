// stop_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/bottom_nav.dart';

class StopPage extends StatelessWidget {
  final String stopName;
  const StopPage({super.key, required this.stopName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green, title: Text(stopName)),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Jimma, located in the Oromia Region of Ethiopia, is a vibrant and historically rich city that offers a unique blend of cultural heritage, natural beauty, and coffee tourism—making it a compelling yet underrated tourist destination.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '☕ Coffee Origin & Culture',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '- Visit traditional coffee farms and participate in coffee ceremonies.',
              ),
              Text(
                '- Explore the Jimma Research Center, a hub for coffee innovation.',
              ),
              Text(
                '- Visit Bonga Forest and the Kaffa Biosphere Reserve, believed to be the natural home of wild coffee.',
              ),
              SizedBox(height: 16),
              Text(
                '📍 How to Get There',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '- By Air: Jimma Airport (JIM) has domestic flights from Addis Ababa.',
              ),
              Text(
                '- By Road: ~350 km southwest of Addis Ababa (6–8 hours by car).',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
