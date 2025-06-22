import 'package:flutter/material.dart';
import '../../widgets/bottom_nav.dart';

class StopPage extends StatelessWidget {
  final String stopName;
  const StopPage({super.key, required this.stopName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.green, title: Text(stopName)),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📷 Image banner
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/9/9d/Bonga%2C_Kaffa.jpg', // Placeholder for Jimma
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // 📄 Description
            const Text(
              'Jimma, located in the Oromia Region of Ethiopia, is a vibrant and historically rich city that offers a unique blend of cultural heritage, natural beauty, and coffee tourism—making it a compelling yet underrated tourist destination.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 24),

            // ☕ Coffee Section
            Row(
              children: const [
                Icon(Icons.local_cafe, color: Colors.brown),
                SizedBox(width: 8),
                Text(
                  'Coffee Origin & Culture',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '• Visit traditional coffee farms and participate in coffee ceremonies.',
            ),
            const Text(
              '• Explore the Jimma Research Center, a hub for coffee innovation.',
            ),
            const Text(
              '• Visit Bonga Forest and the Kaffa Biosphere Reserve, believed to be the natural home of wild coffee.',
            ),

            const SizedBox(height: 24),

            // 📍 How to get there
            Row(
              children: const [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'How to Get There',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '• By Air: Jimma Airport (JIM) has domestic flights from Addis Ababa.',
            ),
            const Text(
              '• By Road: ~350 km southwest of Addis Ababa (6–8 hours by car).',
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
