import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ ATENCIÓN AL CAMBIO DE IP: 
  // - Si usas Emulador Android, déjalo en 'http://10.0.2.2:5000/api'
  // - Si usas Celular Físico, usa la IP local de tu PC (ej. 'http://192.168.1.15:5000/api')
  static const String baseUrl = 'http://192.168.1.47:5000/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'correo': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Credenciales inválidas');
      }
    } catch (e) {
      throw Exception('No se pudo conectar con el servidor: $e');
    }
  }
}