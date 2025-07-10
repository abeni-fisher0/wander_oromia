import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend/data/services/guide_service.dart';

class UploadInfoPage extends StatefulWidget {
  final String trailId;
  const UploadInfoPage({super.key, required this.trailId});

  @override
  State<UploadInfoPage> createState() => _UploadInfoPageState();
}

class _UploadInfoPageState extends State<UploadInfoPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final experienceController = TextEditingController();
  final priceController = TextEditingController();

  final List<String> selectedLanguages = [];
  File? imageFile;

  final List<String> allLanguages = [
    'English',
    'Amharic',
    'Oromo',
    'Tigrigna',
    'French',
    'German',
    'Arabic',
  ];

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  Future<void> handleSave() async {
    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload a photo')),
      );
      return;
    }

    final success = await GuideService.uploadGuide(
      name: nameController.text,
      phone: phoneController.text,
      address: addressController.text,
      experience: experienceController.text,
      languages: selectedLanguages,
      price: priceController.text,
      trailId: widget.trailId,
      imageFile: imageFile!,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Guide info saved')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Failed to save guide info')),
      );
    }
  }

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
                  onPressed: handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 3,
                  ),
                  child: const Text("Upload Info"),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        imageFile != null ? FileImage(imageFile!) : null,
                    backgroundColor: Colors.grey.shade300,
                    child: imageFile == null
                        ? const Icon(Icons.person, size: 60)
                        : null,
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.green,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                      onPressed: pickImage,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildInput(label: "Name", controller: nameController),
            _buildInput(label: "Phone Number", controller: phoneController),
            _buildInput(label: "Address", controller: addressController),
            _buildInput(label: "Years of Experience", controller: experienceController),
            _buildLanguageDropdown(),
            _buildInput(label: "Price for Entire Trail", controller: priceController),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: handleSave,
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

  Widget _buildLanguageDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Languages Spoken", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: allLanguages.map((lang) {
            final isSelected = selectedLanguages.contains(lang);
            return FilterChip(
              label: Text(lang),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedLanguages.add(lang);
                  } else {
                    selectedLanguages.remove(lang);
                  }
                });
              },
              selectedColor: Colors.green.shade200,
              backgroundColor: Colors.grey.shade200,
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
