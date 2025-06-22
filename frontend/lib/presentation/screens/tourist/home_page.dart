// presentation/screens/tourist/home_page.dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discover Trails')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome to Wander Oromia!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Placeholder for categories
          Expanded(
            child: ListView(
              children: const [
                ListTile(title: Text('Festivals')),
                ListTile(title: Text('Food and Cuisine')),
                ListTile(title: Text('Wildlife')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
