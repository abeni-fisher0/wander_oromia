// presentation/screens/common/role_selection_page.dart
import 'package:flutter/material.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose your role')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/signup'),
            child: const Text('Tourist'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/signup'),
            child: const Text('Tour Guide'),
          ),
        ],
      ),
    );
  }
}
