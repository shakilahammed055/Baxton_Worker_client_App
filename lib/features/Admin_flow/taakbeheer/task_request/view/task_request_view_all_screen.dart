import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/controller/task_request_controller2.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/view/task_request_details_form_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskRequestListView extends StatelessWidget {
  final TaskRequestViewAllController taskRequestController2 = Get.put(
    TaskRequestViewAllController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      appBar: AppBar(title: Text('Taakverzoeken'), leading: BackButton()),
      body: Obx(() {
        return ListView.builder(
          itemCount: taskRequestController2.basicRequests.length,
          itemBuilder: (context, index) {
            final task = taskRequestController2.basicRequests[index];
            return Container(
              height: 124,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),

              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.secondaryWhite),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Top: Title and Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          task.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          //overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(task.timeAgo, style: TextStyle(fontSize: 12)),
                    ],
                  ),

                  //SizedBox(height: 8),

                  // Bottom: User info and Details Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(IconPath.person, height: 20),
                          SizedBox(width: 4),
                          Text(task.user),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final detail = taskRequestController2
                                  .getDetailFor(task);
                              Get.to(() => TaskRequestDetailView(task: detail));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGold,
                              foregroundColor: AppColors.primaryWhite,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              side: BorderSide(color: Colors.transparent),
                              minimumSize: Size(62, 29),

                              textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text("Details"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
