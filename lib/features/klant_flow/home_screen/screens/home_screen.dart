// ignore_for_file: unused_local_variable, must_be_immutable
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/core/utils/constants/image_path.dart';
import 'package:baxton/features/klant_flow/home_screen/controller/home_controller.dart';
import 'package:baxton/features/klant_flow/home_screen/widgets/infocard.dart';
import 'package:baxton/features/klant_flow/notification/screens/notification_screen.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/job_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/new_task_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/request_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/task_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/request_screen.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/task_screen.dart';
import 'package:baxton/features/klant_flow/task_screen/widgets/request_service.dart';
import 'package:flutter/material.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_icon_button.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Initialize controllers
  final TaskController taskController = Get.put(TaskController());
  final JobController jobsController = Get.put(JobController());
  final HomeController homeController = Get.put(HomeController());
  final NewTaskController newTaskController = Get.put(NewTaskController());
  RequestController requestController = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      // Show loading indicator while fetching profile
      if (homeController.isLoading.value) {
        return Scaffold(
          backgroundColor: const Color(0xffFAFAFA),
          body: SafeArea(
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primaryGold),
            ),
          ),
        );
      }

      // Show error message with retry option if profile fetch failed
      if (homeController.errorMessage.value.isNotEmpty) {
        return Scaffold(
          backgroundColor: const Color(0xffFAFAFA),
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    homeController.errorMessage.value,
                    style: getTextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      homeController.errorMessage.value = '';
                      homeController.fetchUserProfile();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGold,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.015,
                      ),
                    ),
                    child: Text(
                      'Retry',
                      style: getTextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      // Main UI when profile is loaded or no profile is required
      return Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hallo",
                                style: getTextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Image.asset(
                                IconPath.hi,
                                height: screenWidth * 0.05,
                                width: screenWidth * 0.05,
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Text(
                                homeController.profile.value?.data.user.name ??
                                    "Guest",
                                style: getTextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            "Welkom terug",
                            style: getTextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: screenWidth * 0.06,
                          width: screenWidth * 0.06,
                          decoration: BoxDecoration(
                            color: const Color(0xffFBF6E6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            'assets/icons/notifications.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: screenWidth * 0.045,
                        color: AppColors.buttonPrimary,
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Flexible(
                        child: Text(
                          homeController.profile.value?.data.user.clientProfile
                                  .location ??
                              "Unknown Location",
                          style: getTextStyle(
                            color: AppColors.textSecondary,
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Container(
                    height: screenHeight * 0.18,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold,
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(ImagePath.card),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      child: Text(
                        "Van Schimmel tot \nOnderhoud-wij Hebben \nHet Gedekt.",
                        style: getTextStyle(
                          color: AppColors.textFifth,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  CustomIconButton(
                    text: "Vraag Service Aan",
                    icon: Icons.add,
                    onTap: () {
                      Get.to(() => RequestScreen());
                    },
                    buttonColor: AppColors.buttonPrimary,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    isPrefix: false,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    "Aangevraagde Service",
                    style: getTextStyle(
                      fontSize: screenWidth * 0.06,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Obx(
                    () => newTaskController.requesttasks.isEmpty
                        ? Text(
                            "No requested services available",
                            style: getTextStyle(
                              fontSize: screenWidth * 0.04,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : Column(
                            children: newTaskController.requesttasks
                                .map(
                                  (task) => buildRequestTaskCard(
                                    context,
                                    task,
                                    newTaskController,
                                    screenWidth,
                                  ),
                                )
                                .toList(),
                          ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => TaskScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bekijk Alles",
                          style: getTextStyle(
                            color: AppColors.primaryGold,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: AppColors.primaryGold,
                          size: screenWidth * 0.05,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    "Onze Diensten",
                    style: getTextStyle(
                      fontSize: screenWidth * 0.06,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  InfoCard(
                    title: "Schimmelinspecties & \nBehandelingen",
                    description:
                        "Door inspecties en effectieve behandelingen om \nschimmelproblemen te voorkomen en op te lossen",
                    iconPath: IconPath.moldinspection,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  InfoCard(
                    title: "Voor- en na-inspecties van \nhuurwoningen & Nazorg",
                    description:
                        "Wij bieden inspecties voor en na de overdracht van \nonroerend goed en verzorgen alle nazorg met \nbetrekking tot leveringsproblemen.",
                    iconPath: IconPath.prepostinspection,
                    backgroundColor: const Color(0xffF1CBBC),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  InfoCard(
                    title: "Vochtbeheersing",
                    description:
                        "Wij bieden oplossingen voor vochtproblemen om \nonroerend goed droog en veilig te houden",
                    iconPath: IconPath.moisturecontrol,
                    backgroundColor: const Color(0xff4BBBEB),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  InfoCard(
                    title: "Stucwerk",
                    description:
                        "Alle soorten stucwerk, van renovatie tot afwerking, \nmet aandacht voor detail",
                    iconPath: IconPath.stucco,
                    backgroundColor: const Color(0xffF1CBBC),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  InfoCard(
                    title: "Schilderen & Coaten",
                    description:
                        "Professionele binnen- en buitenschilder- en \ncoatingdiensten voor perfecte resultaten",
                    iconPath: IconPath.painting,
                    backgroundColor: const Color(0xffFFD039),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  InfoCard(
                    title: "Nicotinevlekkenverwijdering",
                    description:
                        "Effectieve verwijdering van nicotinevlekken om een \nschone en frisse binnenomgeving te herstellen.",
                    iconPath: IconPath.nicotine,
                    backgroundColor: const Color(0xff7A6D79),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  InfoCard(
                    title: "Reddersteam & Nooddienst (24/7)",
                    description:
                        "Ons reddersteam is 24/7 beschikbaar voor opruiming \nen ontruiming na brand-, water- of rookschade of in \ngeval van overlijden.",
                    iconPath: IconPath.recueteam,
                    backgroundColor: const Color(0xffFD4755),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}