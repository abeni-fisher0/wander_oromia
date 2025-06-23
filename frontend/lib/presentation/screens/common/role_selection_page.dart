import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  angle: -0.25,
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
                        onPressed: () => context.go('/signup?role=tourist'),
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
                        onPressed: () => context.go('/signup?role=guide'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
          ..strokeWidth = 5
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, 20);
    path.cubicTo(100, 100, 180, 80, 240, 160);
    path.cubicTo(280, 200, 260, 260, 290, 280);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
