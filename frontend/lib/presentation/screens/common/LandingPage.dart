import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });

    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              // Splash Page
              Container(
                color: const Color(0xFF12810E),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('🌳', style: TextStyle(fontSize: 100)),
                      SizedBox(height: 20),
                      Text(
                        'Wander Oromia',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'IrishGrover',
                          fontSize: 36,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              // Welcome Page with Curved Bottom
              const _WelcomeSlide(),

              // Quote Page
              const _QuoteSlide(),

              // Final Page
              const _FinalSlide(),
            ],
          ),

          // Page Indicator Dots
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: WormEffect(
                  activeDotColor: Colors.green,
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 8,
                ),
              ),
            ),
          ),

          // Skip button
          if (_currentPage < 3)
            Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed:
                    () => _controller.animateToPage(
                      3,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ------------------- WELCOME PAGE -------------------
class _WelcomeSlide extends StatelessWidget {
  const _WelcomeSlide();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/horses.jpg',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 90.0),
            child: Text(
              'WELCOME\nTO THE HEART OF\nETHIOPIA',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'IrishGrover',
                fontSize: 28,
                height: 1.3,
                color: Colors.white,
                shadows: [Shadow(blurRadius: 4, color: Colors.black)],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              height: 180,
              color: Colors.white,
              alignment: Alignment.center,
              child: const Text(
                'TRAVEL\nWITH\nMEANING',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'IrishGrover',
                  fontSize: 22,
                  color: Colors.black,
                  height: 1.3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from bottom-left
    path.moveTo(0, 60); // left side (higher)

    // Slanted wave: from top-left to top-right
    path.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.5, 20);
    path.quadraticBezierTo(size.width * 0.75, 40, size.width, 20);

    // Complete the container box
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// ------------------- QUOTE PAGE -------------------
class _QuoteSlide extends StatelessWidget {
  const _QuoteSlide();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/elder.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              '“More than a\ntrip — a \n cultural\njourney.”',
              style: TextStyle(
                fontFamily: 'IrishGrover',
                fontSize: 38,
                height: 1.3,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 3, color: Colors.black)],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ------------------- FINAL PAGE -------------------
class _FinalSlide extends StatelessWidget {
  const _FinalSlide();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🦌 Background
        Image.asset(
          'assets/images/antelope.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),

        // ✨ Trail + Stars group, centered
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: const Offset(70, 0), // Shift left/right if needed
              child: Stack(
                children: [
                  // Trail
                  CustomPaint(
                    size: Size(300, 400),
                    painter: SparkleTrailPainter(),
                  ),

                  // Glowing Stars along path (positions relative to trail box)
                  const Positioned(top: 0, left: 10, child: GlowingStar()),
                  const Positioned(top: 40, left: 80, child: GlowingStar()),
                  const Positioned(top: 100, left: 50, child: GlowingStar()),
                  const Positioned(top: 160, left: 120, child: GlowingStar()),
                  const Positioned(top: 220, left: 90, child: GlowingStar()),
                  const Positioned(top: 280, left: 140, child: GlowingStar()),
                ],
              ),
            ),
          ),
        ),

        // 📜 Text + Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Build your\njourney.\nTravel your way',
                style: TextStyle(
                  fontFamily: 'IrishGrover',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '"Biyyaa bareedduu, biyyoo aadaa\nOromiyaan si waamti."\n(A beautiful land, a land of culture —\nOromia is calling you.)',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IrishGrover',
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  shadows: [Shadow(blurRadius: 2, color: Colors.black)],
                ),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () => GoRouter.of(context).go('/role'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12810E),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}

class GlowingStar extends StatelessWidget {
  final double size;

  const GlowingStar({super.key, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.yellowAccent.withOpacity(0.8),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Text('⭐️', style: TextStyle(fontSize: 24)),
    );
  }
}

class SparkleTrailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.yellowAccent
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(20, 10); // Star 1

    path.quadraticBezierTo(60, 30, 90, 50); // Star 2
    path.quadraticBezierTo(70, 90, 60, 110); // Star 3
    path.quadraticBezierTo(100, 140, 130, 160); // Star 4
    path.quadraticBezierTo(100, 200, 110, 230); // Star 5
    path.quadraticBezierTo(140, 260, 160, 290); // Star 6

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
