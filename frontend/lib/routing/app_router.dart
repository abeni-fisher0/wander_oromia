// routing/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/common/LandingPage.dart';
import '../presentation/screens/common/role_selection_page.dart';
import '../presentation/screens/common/login_page.dart';
import '../presentation/screens/common/signup_page.dart';
import '../presentation/screens/tourist/home_page.dart';

class AppRouter {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LandingPage()),
      GoRoute(
        path: '/role',
        builder: (context, state) => const RoleSelectionPage(),
      ),
      GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      // Add more routes for other screens
    ],
  );
}
