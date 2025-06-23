import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/profile_service.dart';
import '../../widgets/bottom_nav.dart';

class TouristProfilePage extends StatefulWidget {
  const TouristProfilePage({Key? key}) : super(key: key);

  @override
  State<TouristProfilePage> createState() => _TouristProfilePageState();
}

class _TouristProfilePageState extends State<TouristProfilePage> {
  AppUser? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final result = await ProfileService.getProfile();
    setState(() {
      user = result;
      isLoading = false;
    });
  }

  void _navigateToEditProfile(BuildContext context) {
    if (user != null) {
      context.push('/edit-tourist-profile', extra: user);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User data not loaded")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(height: 32),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        user?.avatarUrl ??
                            'https://api.dicebear.com/7.x/initials/svg?seed=${user?.fullName ?? "Tourist"}',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user?.fullName ?? 'Tourist',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${user?.phone ?? 'No phone'} 📞', style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Text('| ${user?.role ?? 'Tourist'}', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _navigateToEditProfile(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: const Text('Edit Profile'),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9FFE0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.bookmark_border, color: Colors.green),
                            title: const Text('Saved Trails'),
                            onTap: () => context.go('/saved'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9FFE0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.logout, color: Colors.green),
                            title: const Text('Log out'),
                            onTap: () => context.go('/login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
