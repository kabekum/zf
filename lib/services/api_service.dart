import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Change this to your Django backend URL
  static const String baseUrl = 'http://10.0.2.2:8000'; // For Android emulator
  // static const String baseUrl = 'http://localhost:8000'; // For iOS simulator
  // static const String baseUrl = 'http://YOUR_IP:8000'; // For physical device

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'error': 'Network error: ${e.toString()}'};
    }
  }

  Future<Map<String, dynamic>> register(
    String username,
    String email,
    String password,
    String password2,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/register/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'password2': password2,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'error': 'Network error: ${e.toString()}'};
    }
  }

  Future<Map<String, dynamic>> logout(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/logout/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'refresh': refreshToken,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'error': 'Network error: ${e.toString()}'};
    }
  }

  Future<Map<String, dynamic>> getUserProfile(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/auth/profile/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'error': 'Network error: ${e.toString()}'};
    }
  }
}
