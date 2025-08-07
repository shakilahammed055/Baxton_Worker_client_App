import 'dart:convert';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/notification_model.dart';

class NotificationRepository {
  final String _baseUrl =
      'https://freepik.softvenceomega.com/ts/notification/get';

  Future<List<NotificationModel>> getNotifications({
    required int take,
    String? cursor,
  }) async {
    final token = await AuthService.getToken();
    debugPrint('token $token');

    final uri = Uri.parse(
      '$_baseUrl?take=$take${cursor != null ? '&cursor=$cursor' : ''}',
    );

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token', 'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);

      if (jsonBody['success'] == true && jsonBody['data'] != null) {
        final List<dynamic> data = jsonBody['data'];
        return data.map((e) => NotificationModel.fromJson(e)).toList();
      } else {
        throw Exception('Unexpected API response structure');
      }
    } else {
      throw Exception('Failed to load notifications');
    }
  }
}
