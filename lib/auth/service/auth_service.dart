import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:user_management/auth/model/login_request.dart';
import 'package:user_management/auth/model/login_response.dart';
import 'package:user_management/shared/api_endpoints.dart';

class AuthService {
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await Get.find<Dio>().post(ApiEndpoints.login,
        data: jsonEncode(request.toJson()),
        options: Options(
          headers: {'content-Type': 'application/json'},
        ));
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception("Failed to login");
    }
  }
}
