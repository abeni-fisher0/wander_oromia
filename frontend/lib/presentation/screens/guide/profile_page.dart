// ✅ Profile Page for Tour Guide
import 'package:flutter/material.dart';
import '../../widgets/guide_bottom_nav.dart';

class GuideProfilePage extends StatelessWidget {
  const GuideProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      bottomNavigationBar: const GuideBottomNavBar(currentIndex: 4),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("assets/images/guide.jpg"),
          ),
          const SizedBox(height: 16),
          const Text("Name: Leenasa Oli"),
          const Text("Phone: +251..."),
          const Text("Address: Addis Ababa"),
          const Text("Experience: 5 years"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/edit-profile");
            },
            child: const Text("Edit Profile"),
          ),
        ],
      ),
    );
  }
}
