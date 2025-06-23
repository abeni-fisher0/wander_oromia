// routing/app_router.dart
import 'package:flutter/material.dart';
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
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/trail/:category',
        builder: (context, state) {
          final category = state.pathParameters['category']!;
          return TrailPage(title: category);
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
      GoRoute(
        path: '/edit-tourist-profile',
        builder: (context, state) => const EditTouristProfilePage(),
      ),

      // 🧭 Guide Routes
      GoRoute(
        path: '/guidehome',
        builder: (context, state) => const GuideHomePage(),
      ),
      GoRoute(
        path: '/guidetrail/:title',
        builder: (context, state) {
          final title = state.pathParameters['title']!;
          return GuideTrailPage(title: title);
        },
      ),
      GoRoute(
        path: '/upload',
        builder: (context, state) => const UploadInfoPage(),
      ),
      GoRoute(
        path: '/guidesaved',
        builder: (context, state) => const guide.SavedTrailsPage(),
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
