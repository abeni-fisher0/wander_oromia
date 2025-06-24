// tourist_trail_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Stop {
  final String name;
  final String description;
  final String image;

  Stop(this.name, this.description, this.image);
}

class TrailPage extends StatelessWidget {
  final String trailId;

  TrailPage({Key? key, required this.trailId}) : super(key: key);

  final Map<String, List<Stop>> trailStops = {
    "trail001": [
      Stop(
        "Hora Arsadi",
        "Main Irreecha site in Bishoftu",
        "assets/images/hora_arsadi1.jpg",
      ),
      Stop(
        "Hora Finfinne",
        "Urban Irreecha in Addis Ababa",
        "assets/images/hora_finfinne.jpg",
      ),
    ],
    "trail002": [
      Stop(
        "Kaffa Forest",
        "Origin of Arabica coffee",
        "assets/images/kaffa_forest.jpg",
      ),
      Stop(
        "Jimma Museum",
        "Coffee culture of Jimma",
        "assets/images/jimma_museum.jpg",
      ),
    ],
    "trail004": [
      Stop("Awash Park", "See oryx and crocodiles", "assets/images/awash.jpg"),
      Stop(
        "Babile Sanctuary",
        "Elephants of Oromia",
        "assets/images/babile.jpg",
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final stops = trailStops[trailId];

    return Scaffold(
      appBar: AppBar(title: const Text("Trail Stops")),
      body:
          stops == null
              ? const Center(child: Text("Trail not found"))
              : ListView.builder(
                itemCount: stops.length,
                itemBuilder: (context, index) {
                  final stop = stops[index];
                  return Card(
                    margin: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          stop.image,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            stop.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(stop.description),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
