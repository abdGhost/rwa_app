import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rwa_app/models/coin_model.dart';
import 'package:rwa_app/models/news_model.dart';
import 'package:rwa_app/models/portfolioToken_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final url = Uri.parse("$_baseUrl/users/signin");

    final body = {"email": email, "password": password};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Signin failed: ${response.body}");
    }
  }

  Future<List<Coin>> fetchCoins({int page = 1, int size = 25}) async {
    final uri = Uri.parse("$_baseUrl/currencies?page=$page&size=$size");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final parsed = CurrenciesResponse.fromJson(json);
      return parsed.currencies;
    } else {
      throw Exception("Failed to load coins: ${response.body}");
    }
  }

  Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse("$_baseUrl/currencies/rwa/news"));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List<dynamic> newsList = jsonBody['news'];
      return newsList.map((newsJson) => News.fromJson(newsJson)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<PortfolioToken>> fetchPortfolio() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await http.get(
      Uri.parse("$_baseUrl/user/token/portfolio"),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List portfolioList = json['portfolioToken'];

      return portfolioList
          .map((item) => PortfolioToken.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to fetch portfolio');
    }
  }

  // ✅ NEW METHOD: Fetch highlight data for market cap and volume
  Future<Map<String, dynamic>> fetchHighlightData() async {
    final url = Uri.parse("$_baseUrl/currencies/rwa/highlight");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == true) {
        return json['highlightData'];
      } else {
        throw Exception("Highlight status false");
      }
    } else {
      throw Exception("Failed to fetch highlight data: ${response.body}");
    }
  }

  // 👇 Add this method to your ApiService class
  Future<Map<String, dynamic>?> fetchTopTrendingCoin() async {
    final url = Uri.parse("$_baseUrl/currencies/rwa/trend");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == true &&
          json['trend'] != null &&
          json['trend'] is List &&
          json['trend'].isNotEmpty) {
        return json['trend'][0]; // return first trending coin only
      } else {
        throw Exception("No trending coins found or status false");
      }
    } else {
      throw Exception("Failed to fetch trending data: ${response.body}");
    }
  }

  Future<List<Coin>> fetchCoinsPaginated({int page = 1, int size = 25}) async {
    final uri = Uri.parse("$_baseUrl/currencies?page=$page&size=$size");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final parsed = CurrenciesResponse.fromJson(json);
      return parsed.currencies;
    } else {
      throw Exception("Failed to load coins: ${response.body}");
    }
  }

  Future<List<Coin>> fetchTrendingCoins() async {
    final url = Uri.parse("$_baseUrl/currencies/rwa/trend");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == true && json['trend'] is List) {
        return (json['trend'] as List)
            .map((item) => Coin.fromJson(item))
            .toList();
      } else {
        throw Exception("Invalid trending response structure");
      }
    } else {
      throw Exception("Failed to load trending coins");
    }
  }
}
