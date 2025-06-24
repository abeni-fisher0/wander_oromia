// routing/app_router.dart
import 'package:flutter/material.dart';
import 'package:frontend/data/models/user_model.dart';
import 'package:go_router/go_router.dart';

// Common Pages
import '../presentation/screens/common/LandingPage.dart';
import '../presentation/screens/common/role_selection_page.dart';
import '../presentation/screens/common/login_page.dart';
import '../presentation/screens/common/signup_page.dart';

// Shared Home Page
import '../presentation/screens/tourist/home_page.dart';

// Tourist Pages
import '../presentation/screens/tourist/trail_page.dart';
import '../presentation/screens/tourist/stop_page.dart';
import '../presentation/screens/tourist/saved_trails.dart' as tourist;
import '../presentation/screens/tourist/itinerary_map_page.dart';
import '../presentation/screens/tourist/cultural_tips_page.dart';
import '../presentation/screens/tourist/profile_page.dart';
import '../presentation/screens/tourist/edit_profile_page.dart';

// Guide Pages
import '../presentation/screens/guide/guide_home_page.dart';
import '../presentation/screens/guide/guide_trail_page.dart';
import '../presentation/screens/guide/guide_saved_trails.dart' as guide;
import '../presentation/screens/guide/profile_page.dart';
import '../presentation/screens/guide/edit_profile_page.dart';
import '../presentation/screens/guide/upload_info_page.dart';

class AppRouter {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LandingPage()),

      GoRoute(
        path: '/role',
        builder: (context, state) => const RoleSelectionPage(),
      ),

      GoRoute(
        path: '/signup',
        builder: (context, state) {
          final role = state.uri.queryParameters['role'];
          return SignUpPage(role: role);
        },
      ),

      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),

      // 🌍 Tourist Routes
      GoRoute(path: '/home', builder: (context, state) => HomePage()),
    
     

      // 🌍 By ID (e.g., "65ae1b...abcd")
     GoRoute(
        path: '/trail/:title',
        builder: (context, state) {
          final title = state.pathParameters['title']!;
          return TrailPage(title: title);
        },
      ),

      GoRoute(
        path: '/stop/:stopName',
        builder: (context, state) {
          final stopName = state.pathParameters['stopName']!;
          return StopPage(stopName: stopName);
        },
      ),
      GoRoute(
        path: '/saved',
        builder: (context, state) => const tourist.SavedTrailsPage(),
      ),
      GoRoute(
        path: '/itinerary',
        builder: (context, state) => const ItineraryMapPage(),
      ),
      GoRoute(
        path: '/culture',
        builder: (context, state) => const CulturalTipsPage(),
      ),
      GoRoute(
        path: '/tourist-profile',
        builder: (context, state) => const TouristProfilePage(),
      ),
      // In your router file
      // In your router file
      GoRoute(
        path: '/edit-tourist-profile',
        pageBuilder: (context, state) {
          try {
            final user = state.extra as AppUser;
            return MaterialPage(
              child: EditTouristProfilePage(initialUser: user),
            );
          } catch (e) {
            // Fallback if something goes wrong
            return MaterialPage(
              child: Scaffold(
                appBar: AppBar(title: Text('Error')),
                body: Center(child: Text('Could not load profile')),
              ),
            );
          }
        },
      ),

      // 🧭 Guide Routes
      GoRoute(
        path: '/guidehome',
        builder: (context, state) => const GuideHomePage(),
      ),
      GoRoute(
        path: '/guidetrail/:trailId',
        builder: (context, state) {
          final trailId = state.pathParameters['trailId']!;
          final title = getTrailTitle(trailId);
          return GuideTrailPage(title: title);
        },
      ),

      GoRoute(
        path: '/upload',
        builder: (context, state) => const UploadInfoPage(),
      ),

      GoRoute(
        path: '/guideprofile',
        builder: (context, state) => const GuideProfilePage(),
      ),
      GoRoute(
        path: '/guide_edit',
        builder: (context, state) => const EditProfilePage(),
      ),
    ],
  );
}

String getTrailTitle(String trailId) {
  switch (trailId) {
    case 'trail001':
      return 'Irreecha Festival Trail';
    case 'trail002':
      return 'Coffee Heritage Trail';
    case 'trail003':
      return 'Bale Mountains Eco Trail';
    case 'trail004':
      return 'Wildlife Discovery Trail';
    case 'trail005':
      return 'Sof Omar Cave Trail';
    case 'trail006':
      return 'Traditional Oromo Dishes Trail';
    case 'trail007':
      return 'Historical Cities Trail';
    default:
      return 'Unknown Trail';
  }
}
