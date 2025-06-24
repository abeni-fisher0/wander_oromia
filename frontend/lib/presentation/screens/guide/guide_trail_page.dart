import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/guide_bottom_nav.dart';
import 'package:go_router/go_router.dart';

class GuideTrailPage extends StatelessWidget {
  final String title;

  const GuideTrailPage({Key? key, required this.title}) : super(key: key);

  List<Map<String, String>> getStopsForTrail(String title) {
    if (title == "Coffee Heritage Trail") {
      return [
        {
          'name': 'Kaffa Forest',
          'align': 'left',
          'image': 'assets/images/kaffa_forest.jpg',
        },
        {
          'name': 'Jimma Museum',
          'align': 'right',
          'image': 'assets/images/jimma_museum.jpg',
        },
      ];
    } else if (title == "Irreecha Festival Trail") {
      return [
        {
          'name': 'Hora Arsadi',
          'align': 'left',
          'image': 'assets/images/hora_arsadi1.jpg',
        },
        {
          'name': 'Hora Finfinne',
          'align': 'right',
          'image': 'assets/images/hora_finfinne.jpg',
        },
      ];
    } else if (title == "Bale Mountains Eco Trail") {
      return [
        {
          'name': 'Sanetti Plateau',
          'align': 'left',
          'image': 'assets/images/saneti.jpg',
        },
        {
          'name': 'Harenna Forest',
          'align': 'right',
          'image': 'assets/images/harenna.jpg',
        },
      ];
    } else if (title == "Wildlife Discovery Trail") {
      return [
        {
          'name': 'Awash NP',
          'align': 'left',
          'image': 'assets/images/awash.jpg',
        },
        {
          'name': 'Babile Sanctuary',
          'align': 'right',
          'image': 'assets/images/babile.jpg',
        },
      ];
    } else {
      return []; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final stops = getStopsForTrail(title);

    return Scaffold(
      appBar: AppBar(
        title: Text('$title Trail'),
        backgroundColor: Colors.green.shade800,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const GuideBottomNavBar(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: stops.length * 200 + 200,
            child: Stack(
              children: [
                // Trail line
                Positioned.fill(
                  child: CustomPaint(painter: TrailLinePainter(stops.length)),
                ),
                // Stop cards
                ...List.generate(stops.length, (index) {
                  final stop = stops[index];
                  final isLeft = stop['align'] == 'left';
                  final topOffset = 60.0 + index * 180;

                  return Positioned(
                    top: topOffset,
                    left: isLeft ? 16 : null,
                    right: isLeft ? null : 16,
                    child: GestureDetector(
                      onTap: () => context.push('/stop/${stop['name']}'),
                      child: Container(
                        width: 150,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.asset(
                                stop['image']!,
                                width: 150,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4,
                              ),
                              child: Text(
                                stop['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0, bottom: 4.0),
                              child: Text(
                                'Learn more',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                // Call to guide
                Positioned(
                  bottom: 30,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Know this trail?',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => context.push('/upload'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Guide',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TrailLinePainter extends CustomPainter {
  final int stopCount;

  TrailLinePainter(this.stopCount);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.green.shade700
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

    for (int i = 0; i < stopCount - 1; i++) {
      final y1 = 150.0 + i * 180;
      final y2 = 150.0 + (i + 1) * 180;
      final x1 = (i % 2 == 0) ? 166 : size.width - 166;
      final x2 = (i % 2 == 0) ? size.width - 166 : 166;

      final path = Path();
      path.moveTo(x1.toDouble(), y1.toDouble());
      path.cubicTo(
        x1.toDouble(),
        (y1 + 40).toDouble(),
        x2.toDouble(),
        (y2 - 40).toDouble(),
        x2.toDouble(),
        y2.toDouble(),
      );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
