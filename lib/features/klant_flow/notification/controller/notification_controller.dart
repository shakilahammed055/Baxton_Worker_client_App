import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/notification_model.dart';
import '../repository/notification_repository.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repo = NotificationRepository();

  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isMoreDataAvailable = true.obs;

  String? _cursor;
  final int _pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications(isInitial: true);
  }

  Future<void> fetchNotifications({bool isInitial = false}) async {
    if (isLoading.value || (!isInitial && !isMoreDataAvailable.value)) return;

    isLoading.value = true;

    if (isInitial) {
      notifications.clear();
      _cursor = null;
      isMoreDataAvailable.value = true;
    }

    try {
      final newData = await _repo.getNotifications(
        take: _pageSize,
        cursor: _cursor,
      );

      if (newData.isNotEmpty) {
        notifications.addAll(newData);
        debugPrint('Loaded notifications count: ${notifications.length}');
        _cursor = newData.last.id;

        if (newData.length < _pageSize) {
          isMoreDataAvailable.value = false;
        }
      } else {
        isMoreDataAvailable.value = false;
      }
    } catch (e) {
      debugPrint('Error fetching notifications: $e');
    }

    isLoading.value = false;
  }

  Future<void> refreshNotifications() async {
    await fetchNotifications(isInitial: true);
  }

  void markAsRead(String notificationId) {
    int index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      final current = notifications[index];
      notifications[index] = NotificationModel(
        id: current.id,
        title: current.title,
        body: current.body,
        data: current.data,
        read: true,
        time: current.time,
        userId: current.userId,
      );
    }
  }
}
