import 'package:flutter/material.dart';
import 'package:frontend/data/services/auth_service.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  final String? role;

  const SignUpPage({Key? key, this.role}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool isLoading = false;
  String? role;

  @override
  void initState() {
    super.initState();
    role = widget.role;
  }

  Future<void> _handleSignUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final fullName = _fullNameController.text.trim();
    final phone = _phoneController.text.trim();

    if (role == null) {
      _showError("Please select a role first.");
      return;
    }

    if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
      _showError("All fields are required.");
      return;
    }

    setState(() => isLoading = true);

    final error = await AuthService.signup({
      'email': email,
      'password': password,
      'name': fullName,
      'phone': phone,
      'role': role,
    });

    setState(() => isLoading = false);

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signed up successfully as $role!")),
      );
      GoRouter.of(context).go('/login');
    } else {
      _showError(error);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 📷 Top image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.asset(
              'assets/images/trai.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 🧾 Sign Up form
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ListView(
                padding: const EdgeInsets.only(top: 24),
                children: [
                  Center(
                    child: Text(
                      'Sign Up as ${role ?? ''}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 🧑 Full name
                  TextField(
                    controller: _fullNameController,
                    decoration: _inputDecoration("FULL NAME"),
                  ),
                  const SizedBox(height: 12),

                  // 📧 Email
                  TextField(
                    controller: _emailController,
                    decoration: _inputDecoration("EMAIL"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),

                  // 🔒 Password
                  TextField(
                    controller: _passwordController,
                    decoration: _inputDecoration("PASSWORD"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),

                  // 📞 Phone
                  TextField(
                    controller: _phoneController,
                    decoration: _inputDecoration("PHONE NUMBER"),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 24),

                  // 🟩 Sign Up button
                  Center(
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _handleSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 🔁 Login redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).go('/login');
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.green),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.green),
      ),
    );
  }
}
