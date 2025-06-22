import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Image(
              image: AssetImage('assets/images/flag.png'),
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: savedTrails.length,
        itemBuilder: (context, index) {
          final trail = savedTrails[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFDFFFD9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () => context.push('/itinerary'),
              child: Row(
                children: [
                  // 📷 Image placeholder (Figma-style grey rounded box)
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image, color: Colors.white70),
                  ),
                  const SizedBox(width: 12),
                  // 🖋️ Title and category
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trail['title'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        trail['category'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
