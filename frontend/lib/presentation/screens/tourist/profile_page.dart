import 'package:flutter/material.dart';
import '../../widgets/bottom_nav.dart';
import 'package:go_router/go_router.dart';

class TouristProfilePage extends StatelessWidget {
  const TouristProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://via.placeholder.com/120',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Bob Dylan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('London ', style: TextStyle(fontSize: 16)),
                Text('🏳️\u200d', style: TextStyle(fontSize: 16)),
                Text(' | Tourist', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                context.push('/edit-profile');
              },
              child: const Text('Edit Profile', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9FFE0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.bookmark_border,
                        color: Colors.green,
                      ),
                      title: const Text('Saved Trails'),
                      onTap: () {
                        context.go('/saved-trails');
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9FFE0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.logout, color: Colors.green),
                      title: const Text('Log out'),
                      onTap: () {
                        context.go('/login');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
    );
  }
}
