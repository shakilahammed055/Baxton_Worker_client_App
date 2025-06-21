import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:baxton/core/utils/constants/colors.dart';

class TaskRequestCard extends StatelessWidget {
  final TaskRequest req;

  const TaskRequestCard({super.key, required this.req});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: AppColors.secondaryWhite),

        //boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  req.title,
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlack,
                    lineHeight: 14,
                  ),
                ),
              ),

              Text(
                req.timeAgo,
                style: getTextStyle(color: AppColors.secondaryBlack),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(IconPath.person),
                  SizedBox(width: 6),
                  Text(req.user),
                ],
              ),
              SizedBox(
                height: 35,
                width: 70,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGold,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    side: BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Details",
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
