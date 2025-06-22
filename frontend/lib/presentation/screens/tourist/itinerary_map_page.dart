import 'package:flutter/material.dart';
import '../../widgets/bottom_nav.dart';

class ItineraryMapPage extends StatelessWidget {
  const ItineraryMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Itinerary and Map')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _dayItem("Day 1-2: Jimma", [
            "cool place 1",
            "cool place 2",
          ], 'assets/images/jimma.png'),
          _dayItem("Day 3: Arsi", [
            "cool place 1",
            "cool place 2",
          ], 'assets/images/arsi.png'),
          _dayItem("Day 4-5: Bale", [
            "cool place 1",
            "cool place 2",
          ], 'assets/images/bale.png'),
          _dayItem("Day 6-7: Goba", [
            "cool place 1",
            "cool place 2",
          ], 'assets/images/goba.png'),
          const SizedBox(height: 20),
          Image.asset('assets/images/map.png'), // Add your local map image
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }

  Widget _dayItem(String title, List<String> places, String imgPath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              imgPath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                ...places.map((p) => Text('- $p')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
