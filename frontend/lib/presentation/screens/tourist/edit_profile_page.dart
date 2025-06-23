import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/profile_service.dart';
import '../../widgets/bottom_nav.dart';

class EditTouristProfilePage extends StatefulWidget {
  final AppUser initialUser;

  const EditTouristProfilePage({Key? key, required this.initialUser}) : super(key: key);

  @override
  State<EditTouristProfilePage> createState() => _EditTouristProfilePageState();
}

class _EditTouristProfilePageState extends State<EditTouristProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;

  bool _isLoading = false;
  bool _passwordVisible = false;
  String? _avatarUrl;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialUser.fullName);
    _emailController = TextEditingController(text: widget.initialUser.email);
    _phoneController = TextEditingController(text: widget.initialUser.phone);
    _passwordController = TextEditingController();
    _avatarUrl = widget.initialUser.avatarUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          _isLoading = true;
        });
        
        final newAvatarUrl = await ProfileService.uploadProfileImage(_imageFile!);
        if (newAvatarUrl != null) {
          setState(() => _avatarUrl = newAvatarUrl);
        }
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Failed to upload image: ${e.toString()}');
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final updateData = {
        'fullName': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        if (_avatarUrl != null && _avatarUrl != widget.initialUser.avatarUrl) 
          'avatarUrl': _avatarUrl,
        if (_passwordController.text.isNotEmpty) 
          'password': _passwordController.text.trim(),
      };

      final success = await ProfileService.updateProfile(updateData);
      
      if (success) {
        final updatedUser = await ProfileService.getProfile();
        if (updatedUser != null) {
          Navigator.pop(context, updatedUser);
          _showSuccess('Profile updated successfully');
          return;
        }
      }
      _showError('Failed to update profile');
    } catch (e) {
      _showError('Error: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      _buildProfilePicture(),
                      const SizedBox(height: 24),
                      _buildFormFields(),
                      const SizedBox(height: 24),
                      _buildSaveButton(),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.green.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: _imageFile != null
                  ? Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                    )
                  : _avatarUrl != null
                      ? Image.network(
                          _avatarUrl!,
                          fit: BoxFit.cover,
                          loadingBuilder: (_, child, progress) {
                            return progress == null
                                ? child
                                : const CircularProgressIndicator();
                          },
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey,
                        ),
            ),
          ),
          Positioned(
            bottom: -8,
            right: -8,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildField(
            label: 'Full Name',
            controller: _nameController,
            icon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildField(
            label: 'Email',
            controller: _emailController,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty || !value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildField(
            label: 'Phone',
            controller: _phoneController,
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          _buildField(
            label: 'New Password (leave blank to keep current)',
            controller: _passwordController,
            icon: Icons.lock_outline,
            obscureText: !_passwordVisible,
            suffixIcon: _passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            onSuffixPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            validator: (value) {
              if (value != null && value.isNotEmpty && value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    IconData? suffixIcon,
    VoidCallback? onSuffixPressed,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon, color: Colors.grey),
                onPressed: onSuffixPressed,
              )
            : null,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 2,
          ),
          onPressed: _isLoading ? null : _saveChanges,
          child: const Text(
            'SAVE CHANGES',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}