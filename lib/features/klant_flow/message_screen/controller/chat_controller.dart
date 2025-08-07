import 'dart:io';

import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class ChatController extends GetxController {

  late IOWebSocketChannel channel;
  final RxList<String> messages = <String>[].obs;
  final RxBool isConnected = false.obs;
  @override
  void onInit() {
    super.onInit();
    debugPrint('🔥 onInit started');
    connectWebSocket();
  }

  Future<String> _getFcmToken() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    final fCMToken = await firebaseMessaging.getToken();
    debugPrint('FCM Token: $fCMToken');
    return fCMToken ?? '';
  }

  Future<void> connectWebSocket() async {
    debugPrint('⚡ connectWebSocket() called');
    try {
      final fcmToken = await _getFcmToken();
      final token = await AuthService.getToken();
      debugPrint('✅ FCM Token: $fcmToken');
      debugPrint('✅ User Token: $token');

      String baseUrl = 'wss://freepik.softvenceomega.com/ts/weak_up';
      final urlWithToken = '$baseUrl?fcm_token=$fcmToken';
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};

      debugPrint('🌐 Connecting to: $urlWithToken');

      final socket = await WebSocket.connect(urlWithToken, headers: headers);
      channel = IOWebSocketChannel(socket);
      isConnected.value = true;
      debugPrint('🔌 WebSocket connected');

      channel.stream.listen(
        (data) {
          debugPrint('📥 Received: $data');
          messages.add(data.toString());
        },
        onError: (error) {
          isConnected.value = false;
          debugPrint('❌ Error: $error');
        },
        onDone: () {
          isConnected.value = false;
          debugPrint('🔕 WebSocket closed');
        },
      );
    } catch (e) {
      debugPrint('❗ WebSocket connection error: $e');
    }
  }
  // Future<void> connectWebSocket() async {
  //   try {
  //     final fcmToken = await _getFcmToken();
  //     final token = await AuthService.getToken();
  //     debugPrint('user Token from : $token');
  //     String baseUrl = 'wss://freepik.softvenceomega.com/ts/weak_up';
  //     final urlWithToken = '$baseUrl?fcm_token=$fcmToken';
  //     final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};

  //     final socket = await WebSocket.connect(urlWithToken, headers: headers);
  //     channel = IOWebSocketChannel(socket);
  //     isConnected.value = true;
  //     channel.stream.listen(
  //       (data) {
  //         debugPrint('📥 Received: $data');
  //         messages.add(data.toString());
  //       },
  //       onError: (error) {
  //         isConnected.value = false;
  //         debugPrint('$error');
  //       },
  //       onDone: () {
  //         isConnected.value = false;
  //         debugPrint('webscoket closed');
  //       },
  //     );
  //   } catch (e) {
  //     debugPrint('not connected to webscoket $e');
  //   }
  // }

  void closeSocket() {
    channel.sink.close();
    isConnected.value = false;
  }

  @override
  void onClose() {
    super.onClose();
    closeSocket();
  }
}
