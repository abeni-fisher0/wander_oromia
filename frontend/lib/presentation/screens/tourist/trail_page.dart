import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/bottom_nav.dart';

class TrailPage extends StatefulWidget {
  final String title;

  const TrailPage({Key? key, required this.title}) : super(key: key);

  @override
  State<TrailPage> createState() => _TrailPageState();
}

class _TrailPageState extends State<TrailPage> {
  final List<String> stops = ['Jimma', 'Arsi', 'Jimma', 'Jimma'];

  // 🔁 Mock tour guides (you can fetch this later from Firebase)
  final List<String> guides = [
    'Abdi Tufa (Jimma)',
    'Lensa Biru (Arsi)',
    'Nati Kedir (Goba)',
  ];

  String? selectedGuide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('${widget.title} Trail'),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔲 Stops grid
            Expanded(
              child: GridView.builder(
                itemCount: stops.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final stop = stops[index];
                  return GestureDetector(
                    onTap: () => context.go('/stop/$stop'),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              stop,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Learn more',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Available Tour Guides:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedGuide,
              hint: const Text('Select a guide'),
              items:
                  guides.map((guide) {
                    return DropdownMenuItem<String>(
                      value: guide,
                      child: Text(guide),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGuide = value;
                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Love this trail?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // save trail or guide selection
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 12,
                ),
              ),
              child: const Text('Save Trail', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
