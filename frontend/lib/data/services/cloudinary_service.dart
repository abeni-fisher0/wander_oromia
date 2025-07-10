import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  static Future<String?> uploadImage(File imageFile) async {
    const String cloudName = 'dyxdo2wqx';
    const String apiKey = '269992887157331';
    const String apiSecret = 'x8adV5Rut_jyJSbGCo87HDqBp-w';

    final String uploadUrl = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
    final String base64 = base64Encode(utf8.encode('$apiKey:$apiSecret'));

    final request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
      ..fields['upload_preset'] = 'ml_default'
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final json = jsonDecode(respStr);
      return json['secure_url'];
    } else {
      print('❌ Cloudinary upload failed: ${response.statusCode}');
      return null;
    }
  }
}
