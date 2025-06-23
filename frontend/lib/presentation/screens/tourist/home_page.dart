import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/presentation/widgets/bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void navigateToTrail(BuildContext context, String category) {
    context.push('/trail/$category');
  }

  Widget buildSection(String title, List<String> images, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => navigateToTrail(context, title.toLowerCase()),
                child: Container(
                  width: 130,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.network(
                          images[index],
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (_, __, ___) => Container(
                                height: 100,
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.image, size: 40),
                              ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Irreecha Trail',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Explore',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final dummyImages = List.generate(
      3,
      (i) => 'https://via.placeholder.com/150',
    );

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavBar(
        currentIndex: 0,
      ), // 👈 Added this line
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Discover places',
                  filled: true,
                  fillColor: Color(0xFFDFFFD9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Welcome to wander Oromia! 🇪🇹',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),
            buildSection('Festivals', dummyImages, context),
            buildSection('Foods and Cuisines', dummyImages, context),
            buildSection('Wildlife preservation', dummyImages, context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
