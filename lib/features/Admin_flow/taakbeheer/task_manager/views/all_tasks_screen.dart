import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/controller/all_task_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/widgets/all_tasks_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTasksScreen extends StatelessWidget {
  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AllTasksController allTasksController = Get.put(AllTasksController());

  AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      key: _scaffoldKey,
      drawer: Navbar(),
      appBar: AppBar(
        title: Text(
          "Task Management / Alle Taken",
          style: getTextStyle(fontSize: 16, color: AppColors.textPrimary),
        ),
        titleSpacing: 0,

        leading: IconButton(
          icon: Image.asset(IconPath.notes),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      // hintText: 'Zoek...',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 12.0,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(IconPath.search),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.borderColor2),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  // icon: const Icon(Icons.filter_alt_outlined),
                  icon: Image.asset(IconPath.filter),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: allTasksController.tasks.length,
                itemBuilder: (_, index) {
                  return AllTaskCard(task: allTasksController.tasks[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
