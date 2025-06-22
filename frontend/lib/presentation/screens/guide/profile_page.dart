import 'package:flutter/material.dart';
import '../../widgets/guide_bottom_nav.dart';
import 'package:go_router/go_router.dart';

class GuideProfilePage extends StatelessWidget {
  const GuideProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const GuideBottomNavBar(currentIndex: 4),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          children: [
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/images/guide.jpg"),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                "Lemessa Oli",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            const Center(
              child: Text(
                "Oromia 🇪🇹 | Tour guide",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  context.push('/edit-profile');
                },
                child: const Text("Edit Profile"),
              ),
            ),
            const SizedBox(height: 30),
            _OptionCard(icon: Icons.bookmark_border, text: "Saved Trails"),
            const SizedBox(height: 16),
            _OptionCard(icon: Icons.logout, text: "Log out"),
          ],
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const _OptionCard({required this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAFDE8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 16),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
