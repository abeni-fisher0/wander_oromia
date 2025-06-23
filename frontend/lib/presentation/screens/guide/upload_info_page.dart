import 'package:flutter/material.dart';

class UploadInfoPage extends StatefulWidget {
  const UploadInfoPage({super.key});

  @override
  State<UploadInfoPage> createState() => _UploadInfoPageState();
}

class _UploadInfoPageState extends State<UploadInfoPage> {
  final TextEditingController nameController = TextEditingController(
    text: 'Lemessa Oli',
  );
  final TextEditingController phoneController = TextEditingController(
    text: '+251',
  );
  final TextEditingController addressController = TextEditingController(
    text: 'street Address',
  );
  final TextEditingController experienceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 3,
                  ),
                  child: const Text("upload information"),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Stack(
              alignment: Alignment.bottomRight,
              children: const [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image(
                    image: AssetImage("assets/images/tourguide.jpg"),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildInput(label: "Name", controller: nameController),
            _buildInput(label: "phone number", controller: phoneController),
            _buildInput(label: "Address", controller: addressController),
            _buildInput(
              label: "years of Experience",
              controller: experienceController,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Send info to backend
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 3,
              ),
              child: const Text("Save", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFEAFDE8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
