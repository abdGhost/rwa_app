import 'package:flutter/material.dart';
import 'package:rwa_app/models/signin_response.dart';
import '../api/api_service.dart';

class SigninController {
  final ApiService _apiService = ApiService();

  Future<SigninResponse> handleSignin(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    final response = await _apiService.signin(email: email, password: password);

    return SigninResponse.fromJson(response);
  }
}
