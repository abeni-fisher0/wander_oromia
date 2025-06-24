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

  void _navigateToEditProfile(BuildContext context) async {
    if (user == null) return;

    final updatedUser = await context.push(
      '/edit-tourist-profile',
      extra: user,
    );
    if (updatedUser is AppUser) {
      setState(() => user = updatedUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      body: SafeArea(
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  children: [
                    const SizedBox(height: 32),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        user?.avatarUrl ??
                            'https://api.dicebear.com/7.x/initials/svg?seed=${Uri.encodeComponent(user?.fullName ?? "Tourist")}',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user?.fullName ?? 'Tourist',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${user?.phone ?? 'No phone'} | ${user?.role ?? 'Tourist'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _navigateToEditProfile(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text('Edit Profile'),
                    ),
                    const SizedBox(height: 32),
                    ListTile(
                      leading: const Icon(Icons.bookmark_border),
                      title: const Text('Saved Trails'),
                      onTap: () => context.go('/saved'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Log out'),
                      onTap: () => context.go('/login'),
                    ),
                  ],
                ),
      ),
    );
  }
}
