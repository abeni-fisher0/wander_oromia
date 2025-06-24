import 'package:flutter/material.dart';
import '../../widgets/bottom_nav.dart';

class CulturalTipsPage extends StatelessWidget {
  const CulturalTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cultural Tips'),
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset('assets/images/logo.png', height: 24),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _tipCard("🎀 Cultural Dress", [
            "🧕 Dress Modestly",
            "🍽️ Injera Meal/Eat Together: Meals are communal. Wash hands and wait to be invited.",
            "🗣️ Honor the Hierarchy/Elders: Use polite language. Age is honored.",
            "🕌 Mosque or Church/Religious Respect: Dress conservatively.",
          ]),
          _tipCard("🧼 Cleanliness & Shoes", [
            "🥿 Remove your shoes when entering someone’s home, mosque, or some churches.",
            "🧴 Always carry hand sanitizer or wet wipes—some rural areas lack restrooms and toilets.",
            "🛑 In rural areas, men and women may have traditional roles.",
            "👂 Tourists follow the lead of locals and ask politely if something is unclear.",
          ]),
          Row(
            children: [
              Expanded(
                child: _tipCard("👋 Greetings & Introductions", [
                  "👋 Hello = Akkam",
                  "🫱 Hi = Akkam jirta?",
                  "🙏 Thank you = Galatoomi",
                  "🚶 Goodbye = Nagaatti",
                ]),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _tipCard("🍽️ Food & Drink", [
                  "😋 I’m hungry = Beela’eera",
                  "🥬 I don’t eat meat = Foon hin nyaadhu",
                  "🤤 Delicious! = Mi’aawe!",
                  "🚰 Water, please = Bishaan mee",
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tipCard(String title, List<String> tips) {
    return Card(
      color: Colors.lightGreen.shade100,
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
            ...tips.map(
              (tip) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(tip, style: const TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
