// ✅ Edit Profile Page
import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            TextField(decoration: InputDecoration(labelText: "Name")),
            TextField(decoration: InputDecoration(labelText: "Phone")),
            TextField(decoration: InputDecoration(labelText: "Address")),
            TextField(decoration: InputDecoration(labelText: "Experience")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: null, child: Text("Save Changes")),
          ],
        ),
      ),
    );
  }
}
