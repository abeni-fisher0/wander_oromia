import 'package:flutter/material.dart';
import '../../widgets/bottom_nav.dart';

class CulturalTipsPage extends StatelessWidget {
  const CulturalTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cultural Tips')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _tipCard("Cultural Dress", [
            "Dress Modestly",
            "Meals are communal. Wash hands and wait to be invited.",
            "Use polite language. Age is honored.",
            "Respect mosques & churches.",
          ]),
          _tipCard("Cleanliness & Shoes", [
            "Remove shoes when entering someone’s home.",
            "Carry hand sanitizer or wet wipes.",
            "Respect indoor/outdoor spaces.",
          ]),
          _tipCard("Greetings", [
            "Hi = Akkam",
            "Hello = Nagaan bula",
            "Thank you = Galatoomi",
            "Goodbye = Nagaatti",
          ]),
          _tipCard("Food & Drink", [
            "I’m hungry = Beela’eera",
            "I don’t eat meat = Foon hin nyaadhu",
            "Delicious = Mi’aawe",
          ], color: Colors.lightGreen[200]!),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }

  Widget _tipCard(
    String title,
    List<String> points, {
    Color color = Colors.white,
  }) {
    return Card(
      color: color,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...points.map(
              (p) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(fontSize: 14)),
                  Expanded(child: Text(p)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
