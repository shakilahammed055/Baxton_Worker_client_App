import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer/controller/medewerkerbeheer_controller.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedewerkerGegevens extends StatelessWidget {
  MedewerkerGegevens({super.key});
  final MedewerkerbeheerController medewerkerbeheerController = Get.put(
    MedewerkerbeheerController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffEBEBEB),
              ),
              child: Icon(Icons.arrow_back_outlined),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Medewerker Gegevens",
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(100.0, 70.0, 0.0, 0.0),
                  color: AppColors.textWhite,
                  items: <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Profiel bewerken',
                      child: Text(
                        'Profiel bewerken',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGold,
                        ),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Status wijzigen',
                      child: Text(
                        'Status wijzigen',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGold,
                        ),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Profiel opschorten',
                      child: Text(
                        'Profiel opschorten',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGold,
                        ),
                      ),
                    ),
                  ],
                ).then((value) {
                  if (value != null) {
                    medewerkerbeheerController.setPosition(value);
                  }
                });
              },
              child: Image.asset(IconPath.menu, height: 16, width: 4),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  child: Image.asset(IconPath.employe, height: 250, width: 250),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Dianne Russell",
                style: getTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Id: 123456789",
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryGold,
                ),
              ),
              SizedBox(height: 20),
              CustomButton(
                title: "Taak Toewijzen",
                onPress: () {},
                borderColor: Colors.transparent,
                backgroundColor: AppColors.buttonPrimary,
                textcolor: Colors.white,
              ),
              SizedBox(height: 20),
              CustomButton(
                title: "Bericht",
                onPress: () {},
                borderColor: AppColors.buttonPrimary,
                backgroundColor: Colors.transparent,
                textcolor: AppColors.buttonPrimary,
              ),
              SizedBox(height: 20),
              Container(
                height: 208,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Expertise",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                          Text(
                            "Dakspecialist",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonPrimary,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Telefoonnummer",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                          Text(
                            "+001 234 567",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonPrimary,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "E-mail",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                          Text(
                            "example123@gmail.com",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonPrimary,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Locatie",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                          Text(
                            "123 Hoofdstraat, Stadsville",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonPrimary,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Toegevoegd",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                          Text(
                            "10 januari 2022",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 88,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Color(0xffEBEBEB)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "30",
                            style: getTextStyle(
                              color: Color(0xff33DB2A),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Totaal Taak",
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 88,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Color(0xffEBEBEB)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "30",
                            style: getTextStyle(
                              color: Color(0xffD9A300),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Totaal Taak",
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 88,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Color(0xffEBEBEB)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "25",
                            style: getTextStyle(
                              color: AppColors.textThird,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Totaal Taak",
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textThird,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Container(
                height: 132,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  border: Border.all(width: 1, color: Color(0xffEBEBEB)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Beoordeling",
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.buttonPrimary,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          IconPath.star,
                          height: 36,
                          width: 36,
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "4.5/5",
                          style: getTextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Alle Taken",
                style: getTextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: Color(0xffF3E2B0)),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(IconPath.filter, height: 24, width: 24),
                  ),
                ),
              ),

              SizedBox(height: 15),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: medewerkerbeheerController.tasks.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final task = medewerkerbeheerController.tasks[index];
                  return TaskCard(
                    title: task.title,
                    userName: task.userName,
                    date: task.date,
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
