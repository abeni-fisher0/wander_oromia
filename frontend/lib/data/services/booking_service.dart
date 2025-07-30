import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/core/utils/token_storage.dart';
import 'package:frontend/data/models/booking_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class BookingService {
  static const String baseUrl = 'http://192.168.1.11:5000/api/bookings';

  // ✅ Create a new booking
  static Future<bool> createBooking(BookingModel booking) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(booking.toJson()),
    );

    if (response.statusCode == 201) {
      print('✅ Booking created');
      return true;
    } else {
      print('❌ Failed to create booking: ${response.statusCode}');
      print('Body: ${response.body}');
      return false;
    }
  }

  // ✅ Fetch all bookings for the logged-in user
  static Future<List<BookingModel>> getBookings() async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("No token found");

    final decoded = JwtDecoder.decode(token);
    final userId = decoded['uid'];

    final url = Uri.parse('$baseUrl/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => BookingModel.fromJson(e)).toList();
    } else {
      print("❌ Backend error: ${response.statusCode}");
      throw Exception('Failed to fetch bookings');
    }
  }
}
