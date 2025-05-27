// import 'package:baxton/features/klant_flow/task_screen/screens/request_screen.dart';
// import 'package:baxton/features/klant_flow/task_screen/widgets/complete_job.dart';
// import 'package:flutter/material.dart';
// import 'package:baxton/core/common/styles/global_text_style.dart';
// import 'package:baxton/core/common/widgets/custom_icon_button.dart';
// import 'package:baxton/core/utils/constants/colors.dart';
// import 'package:baxton/features/klant_flow/home_screen/controller/home_controller.dart';
// import 'package:baxton/features/klant_flow/home_screen/widgets/service_widget.dart';
// import 'package:baxton/features/klant_flow/task_screen/controller/job_controller.dart';
// import 'package:get/get.dart';
// import '../../home_screen/models/home_model.dart';

// class TaskScreen extends StatelessWidget {
//   const TaskScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final JobController jobscontroller = JobController();

//     final HomeController controller = HomeController();
//     final List<Service> services = controller.getFirstTwoServices();
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Mijn Taken",
//                     style: getTextStyle(
//                       color: AppColors.textPrimary,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 CustomIconButton(
//                   text: "Dien Dienst Aan",
//                   icon: Icons.add,
//                   onTap: () {
//                     Get.to(RequestScreen());
//                   },
//                 ),
//                 SizedBox(height: 20),

//                 Text(
//                   "Aangevraagde Dienst",
//                   style: getTextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 for (Service service in services)
//                   ServiceContainer(service: service),
//                 SizedBox(height: 40),
//                 Text(
//                   "Betaal om te bevestigen",
//                   style: getTextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Completejob(jobscontroller: jobscontroller),

//                 SizedBox(height: 40),
//                 Text(
//                   "Voltooide Dienst",
//                   style: getTextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Completejob(jobscontroller: jobscontroller),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:baxton/features/klant_flow/task_screen/screens/request_screen.dart';
import 'package:baxton/features/klant_flow/task_screen/widgets/complete_job.dart';
import 'package:flutter/material.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_icon_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/home_screen/controller/home_controller.dart';
import 'package:baxton/features/klant_flow/home_screen/widgets/service_widget.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/job_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/task_controller.dart';
import 'package:get/get.dart';
import '../../home_screen/models/home_model.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final JobController jobscontroller = JobController();
  final HomeController homeController = HomeController();
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    final List<Service> services = homeController.getFirstTwoServices();

    return Obx(() => Scaffold(
      
          body: SafeArea(
            child: taskController.showRequestScreen.value
                ? RequestScreen(
                    onBack: () => taskController.toggleRequestScreen(false),
                  )
                : _buildTaskContent(services),
          ),
        ));
  }

  Widget _buildTaskContent(List<Service> services) {
    return SingleChildScrollView(
      
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                  "Mijn Taken",
                  style: getTextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ),
             
            const SizedBox(height: 20),
            CustomIconButton(
              text: "Dien Dienst Aan",
              icon: Icons.add,
              onTap: () => taskController.toggleRequestScreen(true),
              isPrefix: false,
            ),
            const SizedBox(height: 20),
            Text(
              "Aangevraagde Dienst",
              style: getTextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            for (Service service in services) ServiceContainer(service: service),
            const SizedBox(height: 40),
            Text(
              "Betaal om te bevestigen",
              style: getTextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            Completejob(jobscontroller: jobscontroller),
            const SizedBox(height: 40),
            Text(
              "Voltooide Dienst",
              style: getTextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            Completejob(jobscontroller: jobscontroller),
          ],
        ),
      ),
    );
  }
}