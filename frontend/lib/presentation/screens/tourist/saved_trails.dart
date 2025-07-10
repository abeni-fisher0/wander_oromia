import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/data/models/booking_model.dart';
import 'package:frontend/data/services/booking_service.dart';
import '../../widgets/bottom_nav.dart';

class SavedTrailsPage extends StatefulWidget {
  const SavedTrailsPage({Key? key}) : super(key: key);

  @override
  State<SavedTrailsPage> createState() => _SavedTrailsPageState();
}

class _SavedTrailsPageState extends State<SavedTrailsPage> {
  List<BookingModel> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    try {
      final data = await BookingService.getBookings();
      setState(() => bookings = data);
    } catch (e) {
      print('❌ Error loading bookings: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booked Trails'),
        backgroundColor: Colors.green,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Image(
              image: AssetImage('assets/images/flag.png'),
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookings.isEmpty
              ? const Center(child: Text('You haven’t booked any trails yet.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    final trail = booking.trail;
                    final guide = booking.guide;

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFFFD9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: trail?.imageUrl != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      trail!.imageUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(Icons.image, color: Colors.white70),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trail?.title ?? 'Unknown Trail',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Guide: ${guide?.name ?? "N/A"}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  'Start: ${booking.date.toLocal().toString().split(' ')[0]}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.push('/chat', extra: {'guideId': guide?.id});
                            },
                            icon: const Icon(Icons.message),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
