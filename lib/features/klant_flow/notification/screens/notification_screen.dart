// import 'package:baxton/core/common/styles/global_text_style.dart';
// import 'package:baxton/core/utils/constants/colors.dart';
// import 'package:baxton/core/utils/constants/icon_path.dart';
// import 'package:flutter/material.dart';

// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Meldingen",
//           style: getTextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimary,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               SizedBox(
//                 width: 361,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Header Section
//                     SizedBox(
//                       width: double.infinity,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Meldingen',
//                               style: getTextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w500,
//                                 color: const Color(0xFF1E293B),
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 // Implement mark all as read functionality
//                               },
//                               child: Text(
//                                 'Markeer alles als gelezen',
//                                 style: getTextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                   color: const Color(0xFF2E70E8),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     // Notification List
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Notification Item 1 (Unread)
//                         _buildNotificationItem(
//                           avatarInitials: 'SJ',
//                           avatarBackgroundColor: const Color(0xFFE2E8F0),
//                           avatarTextColor: const Color(0xFF72839A),
//                           message:
//                               'Je taak om het dak van het XYZ-pand te inspecteren is toegewezen. Bekijk de details.',
//                           messageColor: const Color(0xFF0D3C6B),
//                           time: '15h',
//                           isUnread: true,
//                           backgroundColor: const Color(0xFFEDF3FF),
//                         ),
//                         const SizedBox(height: 12),
//                         // Notification Item 2
//                         _buildNotificationItem(
//                           message:
//                               'Het loodgietersysteem van het ABC-gebouw heeft onderhoud nodig. Plan een bezoek.',
//                           messageColor: const Color(0xFF333333),
//                           time: '2d',
//                           isUnread: false,
//                           backgroundColor: Colors.white,
//                         ),
//                         const SizedBox(height: 12),
//                         // Notification Item 3
//                         _buildNotificationItem(
//                           message:
//                               'Je hebt een vergadering over het HVAC-systeem op het DEF-kantoor. Bevestig je aanwezigheid.',
//                           messageColor: const Color(0xFF333333),
//                           time: '1d',
//                           isUnread: false,
//                           backgroundColor: Colors.white,
//                         ),
//                         const SizedBox(height: 12),
//                         // Notification Item 4 (Unread)
//                         _buildNotificationItem(
//                           message:
//                               'Het landschapsontwerp voor het GHI-park is afgerond. Bekijk de voorstellen.',
//                           messageColor: const Color(0xFF0D3C6B),
//                           time: '3d',
//                           isUnread: true,
//                           backgroundColor: const Color(0xFFEDF3FF),
//                         ),
//                         const SizedBox(height: 12),
//                         // Notification Item 5
//                         _buildNotificationItem(
//                           message:
//                               'Evalueer alstublieft de elektrische bedrading in het JKL-magazijn. Rapporteer bevindingen.',
//                           messageColor: const Color(0xFF333333),
//                           time: '5h',
//                           isUnread: false,
//                           backgroundColor: Colors.white,
//                         ),
//                         const SizedBox(height: 12),
//                         // Notification Item 6
//                         _buildNotificationItem(
//                           message:
//                               'De brandveiligheidsaudit voor het MNO-complex is binnenkort verschuldigd. Bereid de benodigde documenten voor.',
//                           messageColor: const Color(0xFF333333),
//                           time: '1w',
//                           isUnread: false,
//                           backgroundColor: Colors.white,
//                         ),
//                         const SizedBox(height: 12),
//                         // Notification Item 7
//                         _buildNotificationItem(
//                           message:
//                               'Je analyse van bouwmaterialen voor de PQR-locatie is nu nodig. Dien je rapport in.',
//                           messageColor: const Color(0xFF333333),
//                           time: '4d',
//                           isUnread: false,
//                           backgroundColor: Colors.white,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNotificationItem({
//     String? avatarInitials,
//     Color? avatarBackgroundColor,
//     Color? avatarTextColor,
//     required String message,
//     required Color messageColor,
//     required String time,
//     required bool isUnread,
//     required Color backgroundColor,
//   }) {
//     return Container(
//       width: double.infinity,
//       decoration: ShapeDecoration(
//         color: backgroundColor,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(24),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Avatar
//                 Container(
//                   width: 48,
//                   height: 48,
//                   decoration: ShapeDecoration(
//                     color: avatarBackgroundColor ?? Colors.transparent,
//                     shape: const OvalBorder(),
//                     image: avatarInitials == null
//                         ? const DecorationImage(
//                             image: AssetImage(
//                               IconPath.profileimage
//                             ),
//                             fit: BoxFit.cover,
//                           )
//                         : null,
//                   ),
//                   child: avatarInitials != null
//                       ? Center(
//                           child: Text(
//                             avatarInitials,
//                             style: getTextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w600,
//                               color: avatarTextColor ?? Colors.black,
//                               lineHeight: 12

//                             ),
//                           ),
//                         )
//                       : null,
//                 ),
//                 const SizedBox(width: 12),
//                 // Message
//                 Expanded(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: 225,
//                         child: Text(
//                           message,
//                           style: getTextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: messageColor,
//                             lineHeight: 12

//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 // Time
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       time,
//                       style: getTextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: const Color(0xFF475569),

//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           if (isUnread)
//             Positioned(
//               left: 10,
//               top: 43,
//               child: Container(
//                 width: 8,
//                 height: 8,
//                 decoration: const ShapeDecoration(
//                   color: Color(0xFF2E70E8),
//                   shape: OvalBorder(),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:baxton/features/klant_flow/notification/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                width: 361,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text(
                            'Meldingen',
                            style: getTextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.markAllAsRead();
                            },
                            child: Text(
                              'Markeer alles als gelezen',
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF2E70E8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Notification List
                    ValueListenableBuilder<List<NotificationItem>>(
                      valueListenable: controller.notifications,
                      builder: (context, notifications, _) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              notifications.asMap().entries.map((entry) {
                                final index = entry.key;
                                final notification = entry.value;
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.markAsRead(index);
                                      },
                                      child: _buildNotificationItem(
                                        avatarInitials:
                                            notification.avatarInitials,
                                        avatarBackgroundColor:
                                            notification.avatarBackgroundColor,
                                        avatarTextColor:
                                            notification.avatarTextColor,
                                        message: notification.message,
                                        messageColor: notification.messageColor,
                                        time: notification.time,
                                        isUnread: notification.isUnread,
                                        backgroundColor:
                                            notification.backgroundColor,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                );
                              }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    String? avatarInitials,
    Color? avatarBackgroundColor,
    Color? avatarTextColor,
    required String message,
    required Color messageColor,
    required String time,
    required bool isUnread,
    required Color backgroundColor,
  }) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: ShapeDecoration(
                    color: avatarBackgroundColor ?? Colors.transparent,
                    shape: const OvalBorder(),
                    image:
                        avatarInitials == null
                            ? const DecorationImage(
                              image: AssetImage(IconPath.profileimage),
                              fit: BoxFit.cover,
                            )
                            : null,
                  ),
                  child:
                      avatarInitials != null
                          ? Center(
                            child: Text(
                              avatarInitials,
                              style: getTextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: avatarTextColor ?? Colors.black,
                                lineHeight: 12,
                              ),
                            ),
                          )
                          : null,
                ),
                const SizedBox(width: 12),
                // Message
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 225,
                        child: Text(
                          message,
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: messageColor,
                            lineHeight: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Time
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
}
