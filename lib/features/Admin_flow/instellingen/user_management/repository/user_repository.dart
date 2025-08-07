// repository/user_repository.dart
import 'dart:convert';
import 'package:baxton/features/Admin_flow/instellingen/user_management/model/user_model.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl = "https://freepik.softvenceomega.com/ts/admin/all-user";

  Future<List<UserModel>> fetchAllUsers() async {
    try {
      String? token = await AuthService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Auth token is missing');
      }

      final url = Uri.parse(baseUrl);

      final response = await http.get(
        url,
        headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        debugPrint('userList ${response.body}');
        return jsonList.map((e) => UserModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      // You can log the error or rethrow with more info
      throw Exception('Error fetching users: $e');
    }
  }
}
