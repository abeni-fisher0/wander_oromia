import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          const _IntroSlide(
            bgColor: Color(0xFF2E7D32),
            image: null,
            child: Text(
              'Wander Oromia',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontFamily: 'Serif',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const _IntroSlide(
            image: 'assets/images/horses.jpg',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'WELCOME TO THE HEART OF ETHIOPIA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'TRAVEL WITH MEANING',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const _IntroSlide(
            image: 'assets/images/elder.jpg',
            child: Text(
              '“More than a trip — a cultural journey.”',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          _IntroSlide(
            image: 'assets/images/antelope.jpg',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Build your journey.\nTravel your way',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '“Biyyaa bareedduu, biyya aadaa Oromiyaan si waamti.”\n(A beautiful land. A land of culture — Oromia is calling you.)',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      const StadiumBorder(),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                  onPressed: () => GoRouter.of(context).go('/role'),
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroSlide extends StatelessWidget {
  final String? image;
  final Widget child;
  final Color? bgColor;

  const _IntroSlide({super.key, this.image, required this.child, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (image != null) Image.asset(image!, fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.45)),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
