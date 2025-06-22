import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/data/services/auth_service.dart';
import 'package:frontend/data/services/user_api.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
  String? role;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      role = args;
    }
  }

  Future<void> _handleSignUp() async {
    if (role == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a role first.")),
      );
      return;
    }

    setState(() => isLoading = true);
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final token = await AuthService().signUp(email, password);
      if (token == null) throw Exception("Signup failed. No token returned.");

      final res = await UserApi().registerUser(token, role!);
      if (res.statusCode == 200 || res.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Registered as $role!")));
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        final msg = _parseBackendError(res);
        throw Exception(msg);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  String _parseBackendError(http.Response res) {
    try {
      final Map<String, dynamic> body = jsonDecode(res.body);
      return body['message'] ?? body['error'] ?? "Unexpected error";
    } catch (_) {
      return "Server error (${res.statusCode})";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : _handleSignUp,
              child:
                  isLoading
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
