// lib/presentation/screens/tourist/edit_tourist_profile_page.dart
import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/profile_service.dart';

class EditTouristProfilePage extends StatefulWidget {
  final AppUser initialUser;

  const EditTouristProfilePage({Key? key, required this.initialUser})
    : super(key: key);

  @override
  State<EditTouristProfilePage> createState() => _EditTouristProfilePageState();
}

class _EditTouristProfilePageState extends State<EditTouristProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.initialUser.fullName ?? '',
    );
    _emailController = TextEditingController(
      text: widget.initialUser.email ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.initialUser.phone ?? '',
    );
    _passwordController = TextEditingController();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final updateData = {
        'name': _nameController.text.trim(), // ✅ fixed key name
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        if (_passwordController.text.isNotEmpty)
          'password': _passwordController.text.trim(),
      };

      final success = await ProfileService.updateProfile(updateData);
      if (success) {
        final updatedUser = await ProfileService.getProfile();
        if (updatedUser != null) {
          Navigator.pop(context, updatedUser);
          return;
        }
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to update profile')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                        ),
                        validator:
                            (value) =>
                                value!.isEmpty ? 'Enter your name' : null,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator:
                            (value) =>
                                value!.isEmpty ? 'Enter your email' : null,
                      ),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(labelText: 'Phone'),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'New Password',
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _saveChanges,
                        child: const Text('Save Changes'),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
