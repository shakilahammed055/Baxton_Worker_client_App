import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_icon_button.dart';
import 'package:baxton/core/common/widgets/custom_search_field.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/admin_home/controller/home_screen_controller.dart';
import 'package:baxton/features/Admin_flow/admin_home/model/recent_taskmodel.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
import 'package:baxton/features/Admin_flow/admin_home/widgets/pie_chart_widgets.dart';
import 'package:baxton/features/Admin_flow/admin_home/widgets/recent_taken_widget.dart';
import 'package:baxton/features/klant_flow/profile_screen/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({super.key});
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  final ProfileController profileController = Get.put(ProfileController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Navbar(),
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Image.asset(IconPath.notes),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomSearchTextField(
                    hintText: "",
                    controller: homeScreenController.searchController,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 18,
                      color: AppColors.primaryGold,
                    ),
                  ),
                ),
              ),
              // Notification icon at top right
              SizedBox(
                width: 17,
                height: 20,
                child: Image.asset(IconPath.notifications),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Hallo Russell!",
                        style: getTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Welkom terug",
                        style: getTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(IconPath.profilepic),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32),
              piechartwidget(),
              SizedBox(height: 20),
              Container(
                height: 77,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xffFBF6E6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(IconPath.task, height: 32, width: 32),
                      Text(
                        "Totaal Taken",
                        style: getTextStyle(
                          color: Color(0xff666666),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        height: 37,
                        width: 37,
                        decoration: BoxDecoration(
                          color: Color(0xffD9A300),
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "100",
                            style: getTextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 181,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  border: Border.all(width: 1, color: Color(0xffEBEBEB)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Medewerker Overzicht",
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.buttonPrimary,
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          IconPath.group,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Active Medewerker",
                                style: getTextStyle(
                                  color: Color(0xffA1A1A1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "120",
                                style: getTextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff1E90FF),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Gemiddelde Beoordeling",
                                style: getTextStyle(
                                  color: Color(0xffA1A1A1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "4.4",
                                style: getTextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffFFE352),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 33),
              Row(
                children: [
                  Expanded(
                    child: CustomIconButton(
                      text: "Nieuwe Taak",
                      icon: Icons.add,
                      onTap: () {},
                      isPrefix: false,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomIconButton(
                      text: "Rapport",
                      textColor: AppColors.buttonPrimary,
                      icon: Icons.trending_up_sharp,
                      iconColor: AppColors.buttonPrimary,
                      onTap: () {},
                      buttonColor: Colors.white,
                      borderWidth: 1,
                      borderColor: AppColors.buttonPrimary,
                      isPrefix: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                "Recente Taken",
                style: getTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 20),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recentTasks.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final task = recentTasks[index];
                  return RecentTaskItem(
                    taskName: task.name,
                    location: task.location,
                    workerName: task.workerName,
                    timeAgo: task.timeAgo,
                    status: task.status,
                    statusColor: task.statusColor,
                    statusTextColor: task.statusTextColor,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
