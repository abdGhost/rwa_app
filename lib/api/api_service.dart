import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://rwa-f1623a22e3ed.herokuapp.com/api";

  Future<Map<String, dynamic>> signup({
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse("$_baseUrl/users/signup");

    final body = {
      "email": email,
      "userName": username,
      "password": password,
      "confirmPassword": confirmPassword,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Signup failed: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> signin({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(
      "https://rwa-f1623a22e3ed.herokuapp.com/api/users/signin",
    );

    final body = {"email": email, "password": password};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw response.body; // Throw so we can catch & show message
    }
  }
}
