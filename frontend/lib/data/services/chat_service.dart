import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/chat_message_model.dart';
import 'package:frontend/core/utils/token_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ChatService {
  static const String baseUrl = 'http://192.168.1.9:5000/api';

  static Future<List<ChatMessage>> getChat(String receiverId) async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("No token found");

    final decoded = JwtDecoder.decode(token);
    final senderId = decoded['uid'];

    final response = await http.get(
      Uri.parse('$baseUrl/chats/$senderId/$receiverId'),
    );

    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((json) => ChatMessage.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chat');
    }
  }

  static Future<bool> sendMessage({
    required String receiverId,
    required String message,
  }) async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("No token found");

    final decoded = JwtDecoder.decode(token);
    final senderId = decoded['uid'];

    final response = await http.post(
      Uri.parse('$baseUrl/chats'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
      }),
    );

    return response.statusCode == 201;
  }
}
