import 'package:baxton/features/klant_flow/notification/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Meldingen",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          // Initial loading indicator
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () async => controller.refreshNotifications(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount:
                controller.notifications.length +
                (controller.isMoreDataAvailable.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.notifications.length) {
                final notification = controller.notifications[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () => controller.markAsRead(notification.id),
                    child: _buildNotificationItem(
                      imageUrl: notification.data.clientProfile.url,
                      message: notification.body,
                      time: _formatTime(notification.time),
                      isUnread: !notification.read,
                      backgroundColor:
                          notification.read
                              ? Colors.white
                              : const Color(0xFFEFF6FF),
                    ),
                  ),
                );
              } else {
                // Load more button or loading indicator
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      onPressed:
                          controller.isLoading.value
                              ? null
                              : controller.fetchNotifications,
                      child:
                          controller.isLoading.value
                              ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                              : const Text("Laad meer"),
                    ),
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }

  Widget _buildNotificationItem({
    required String imageUrl,
    required String message,
    required String time,
    required bool isUnread,
    required Color backgroundColor,
  }) {
    return Container(
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar Image with error fallback
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage:
                      imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                  child:
                      imageUrl.isEmpty
                          ? const Icon(
                            Icons.person,
                            size: 24,
                            color: Colors.grey,
                          )
                          : null,
                ),
                const SizedBox(width: 12),
                // Message and Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1E293B),
                          lineHeight: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        time,
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isUnread)
            Positioned(
              left: 10,
              top: 43,
              child: Container(
                width: 8,
                height: 8,
                decoration: const ShapeDecoration(
                  color: Color(0xFF2E70E8),
                  shape: OvalBorder(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(time); // today
    } else if (difference.inDays == 1) {
      return 'Gisteren'; // Yesterday
    } else if (difference.inDays < 7) {
      return '${difference.inDays} dagen geleden'; // x days ago
    } else {
      return DateFormat('dd MMM yyyy').format(time); // older
    }
  }
}
