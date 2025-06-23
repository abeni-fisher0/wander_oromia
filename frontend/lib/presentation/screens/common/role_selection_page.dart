import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(title: const Text('Choose Your Role')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get started as:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => context.go('/signup?role=tourist'),
                icon: const Icon(Icons.travel_explore),
                label: const Text('Tourist'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => context.go('/signup?role=guide'),
                icon: const Icon(Icons.map),
                label: const Text('Tour Guide'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ),
=======
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/images/role.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),

          // Arc + Trail + Star
          Positioned(
            top: -80,
            left: -100,
            child: Container(
              width: 360,
              height: 280,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned.fill(child: CustomPaint(painter: RoleTrailPainter())),
          const Positioned(
            top: 260,
            left: 285,
            child: Text('⭐️', style: TextStyle(fontSize: 36)),
          ),

          // 🌍 App Title + Flag
          Positioned(
            top: 90,
            right: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Transform.rotate(
                  angle: -0.25, // More tilt left
                  child: const Text(
                    'Wander\nOromia',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'IrishGrover',
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ClipOval(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),

          // 🙋 Role Options Section
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100, left: 30, right: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'I am a:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tourist Button
                  Center(
                    child: SizedBox(
                      width: 240,
                      child: _RoleButton(
                        label: 'Tourist',
                        onPressed:
                            () => Navigator.pushNamed(context, '/signup'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tour Guide Button
                  Center(
                    child: SizedBox(
                      width: 240,
                      child: _RoleButton(
                        label: 'Tour Guide',
                        onPressed:
                            () => Navigator.pushNamed(context, '/signup'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
>>>>>>> bdd0150ee0449159f15d497da51f80341f3b1123
      ),
    );
  }
}

// ✅ Reusable Role Button
class _RoleButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _RoleButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF12810E),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 4,
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class RoleTrailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.lightGreenAccent
          ..strokeWidth =
              5 // ✅ Thicker line
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round; // optional: round line edges

    final path = Path();
    path.moveTo(0, 20); // Start from arc

    // ✅ Use smoother cubic Bezier curves for natural flow
    path.cubicTo(
      100,
      100, // Control point 1
      180,
      80, // Control point 2
      240,
      160, // End point of first curve
    );

    path.cubicTo(
      280,
      200, // Control point 1
      260,
      260, // Control point 2
      290,
      280, // End point of second curve (extends deeper)
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
