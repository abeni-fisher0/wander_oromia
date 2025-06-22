import 'package:flutter/material.dart';
import '../../widgets/bottom_nav.dart';

class ItineraryMapPage extends StatelessWidget {
  const ItineraryMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itinerary and Map'),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('assets/images/map.png', fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }

  Widget _dayItem(String title, List<String> places, String imgPath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              imgPath,
              width: 55,
              height: 55,
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                ...places.map(
                  (p) => Text('- $p', style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
