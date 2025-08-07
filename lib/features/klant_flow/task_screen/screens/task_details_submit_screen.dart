// ignore_for_file: sort_child_properties_last

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/bottom_navigationbar/screens/bottom_navigation_ber.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/task_submit_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/details/view/widget/new_checkList_widget.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/upcoming_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';

class TaskDetailsSubmitScreen extends StatelessWidget {
  final String taskId;
  final UpcomingTaskController controller = Get.put(UpcomingTaskController());

  TaskDetailsSubmitScreen({super.key, required this.taskId});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTaskDetails(taskId);
    });

    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              const SizedBox(width: 16),
              Image.asset(IconPath.arrowBack),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Taakdetails",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primaryBlack),
      ),
      body: Obx(() {
        final data = controller.taskDetailsModel.value;
        if (data == null) {
          return const Center(child: Text('Geen gegevens beschikbaar'));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTaskInfoView(data),
              SizedBox(height: 10.h),
              _buildPaymentType(data),
              SizedBox(height: 10.h),
              _buildChecklistSection(context, controller),
              SizedBox(height: 40.h),
              _buildBeforePhotosSection(controller),
              SizedBox(height: 40.h),
              _buildAfterPhotosSection(controller),
              SizedBox(height: 40.h),
              _buildSignatureView(data),
              SizedBox(height: 20.h),
              _buildNoteView(data),
              SizedBox(height: 32.h),
              CustomContinueButton(
                onTap: () async {
                  final rating = controller.selectedValue.value;
                  final review = controller.reviewController.text;
                  final signatureFile = controller.signatureFile;
                  debugPrint("🔍 Submitting task with:");
                  debugPrint("• taskId: $taskId");
                  debugPrint("• rating: $rating");
                  debugPrint("• review: $review");
                  debugPrint("• signatureFile: ${signatureFile?.path}");

                  if (signatureFile == null || review.isEmpty) {
                    debugPrint(
                      "❌ Validation failed: signature or review missing.",
                    );
                    Get.snackbar(
                      "Fout",
                      "Vul handtekening en beoordeling in.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.withValues(alpha: 0.8),
                      colorText: Colors.white,
                    );
                    return;
                  }

                  final submitController = Get.put(TaskSubmitController());
                  await submitController.submitTask(
                    taskId: taskId,
                    signature: signatureFile,
                    rating: rating,
                    review: review,
                  );
                  Get.to(() => ClientBottomNavbar());
                },

                title: "Indienen",
                backgroundColor: AppColors.buttonPrimary,
                textColor: AppColors.textWhite,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildNoteView(data) {
    final reviewItem = data.reviews;

    final String? review = reviewItem?.review;
    final double? rating = reviewItem?.rating;

    final bool showReviewInput = review == null || review.isEmpty;
    final bool showRatingInput = rating == null;

    // REVIEW
    if (!showReviewInput) {
      // Show existing review text
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Laat een beoordeling achter",
            style: getTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(review, style: getTextStyle(fontSize: 16)),
          const SizedBox(height: 16),

          // RATING (show existing or input)
          if (!showRatingInput)
            Row(
              children: [
                Text("Rating: $rating", style: getTextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Image.asset(IconPath.star, height: 16, width: 16),
              ],
            )
          else
            _buildRatingInput(),
        ],
      );
    }

    // REVIEW input field + rating input or display
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Laat een beoordeling achter",
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller.reviewController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Schrijf hier uw beoordeling...",
            filled: true,
            fillColor: const Color(0xffC0C0C0).withValues(alpha: 0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // RATING (input or display)
        if (showRatingInput)
          _buildRatingInput()
        else
          Row(
            children: [
              Text("Rating: $rating", style: getTextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Image.asset(IconPath.star, height: 16, width: 16),
            ],
          ),
      ],
    );
  }

  Widget _buildRatingInput() {
    return Container(
      height: 40,
      width: 105,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffC0C0C0), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(
        () => DropdownButton<int>(
          value: controller.selectedValue.value,
          icon: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Image.asset(IconPath.dropdown, height: 20, width: 20),
          ),
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          underline: Container(height: 2, color: Colors.transparent),
          onChanged: (int? newValue) {
            if (newValue != null) {
              controller.selectedValue.value = newValue;
            }
          },
          items:
              <int>[1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(value.toString()),
                        const SizedBox(width: 8),
                        Image.asset(IconPath.star, height: 15, width: 15),
                      ],
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildSignatureView(data) {
    final signatureUrl = data.signature?.url;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Uw Handtekening",
            style: getTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 12),
        signatureUrl != null && signatureUrl.isNotEmpty
            ? Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  signatureUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 50);
                  },
                ),
              ),
            )
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Teken uw handtekening hieronder:"),
                const SizedBox(height: 10),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Signature(
                    controller: controller.signaturePadController,
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: controller.saveSignature,
                      child: const Text("Opslaan"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonPrimary,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: controller.clearSignature,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide.none,
                        ),
                      ),
                      child: const Text("Wissen"),
                    ),
                  ],
                ),
              ],
            ),
      ],
    );
  }

  Widget _buildTaskInfoView(dynamic data) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffEBEBEB)),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(15.sp),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.name ?? 'No Task Name',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(data.problemDescription ?? 'No Description'),
          SizedBox(height: 16.h),
          _buildTimeAndLocationRow(data),
        ],
      ),
    );
  }

  Widget _buildTimeAndLocationRow(dynamic data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 20.sp,
              color: AppColors.buttonPrimary,
            ),
            SizedBox(width: 4.w),
            Text(
              data.preferredTime != null
                  ? data.preferredTime!.split('T')[1].substring(0, 5)
                  : 'No data',
            ),
          ],
        ),
        SizedBox(width: 10.w),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 20.sp,
              color: AppColors.buttonPrimary,
            ),
            const SizedBox(width: 4),
            Text(data.city ?? 'No data'),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentType(dynamic data) {
    return Container(
      width: double.infinity,
      height: 50.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xffFBF6E6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '\$${data.basePrice?.toStringAsFixed(2) ?? '0.00'}',
        style: GoogleFonts.roboto(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryGold,
        ),
      ),
    );
  }

  Widget _buildChecklistSection(
    BuildContext context,
    UpcomingTaskController upcomingTaskController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "TaakChecklist",
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        const SizedBox(height: 20),

        Obx(() {
          // final details = upcomingTaskController.taskDetailsModel.value;
          // final items = details?.tasks ?? [];

          final details = upcomingTaskController.taskDetailsModel.value;
          final allItems = details?.tasks ?? [];
          final items = allItems.where((item) => item.done == true).toList();
          debugPrint("✅ Checklist completed items: ${items.length}");
          if (items.isEmpty) {
            return const Text('Geen checklist items.');
          }

          return Column(
            children:
                items.map((item) {
                  return NewChecklistWidget(item: item, onChanged: (val) {});
                }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildBeforePhotosSection(
    UpcomingTaskController upcomingTaskController,
  ) {
    return Obx(() {
      final beforePhotos =
          upcomingTaskController.taskDetailsModel.value?.beforePhoto ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPhotoUploadSectionView(
            onTap: () {},
            buttonText: "Voor Foto",
            photos: beforePhotos,
          ),
        ],
      );
    });
  }

  Widget _buildAfterPhotosSection(
    UpcomingTaskController upcomingTaskController,
  ) {
    return Obx(() {
      final afterPhotos =
          upcomingTaskController.taskDetailsModel.value?.afterPhoto ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPhotoUploadSectionView(
            onTap: () {},
            buttonText: "Na Foto",
            photos: afterPhotos,
          ),
        ],
      );
    });
  }

  Widget _buildPhotoUploadSectionView({
    required VoidCallback onTap,
    required String buttonText,
    required List<dynamic> photos,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 70,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.secondaryBlue,
              border: Border.all(color: AppColors.primaryBlue),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(IconPath.camera),
                const SizedBox(height: 8),
                Text(
                  buttonText,
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        // 📷 Show images from API (not local)
        if (photos.isEmpty)
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: AppColors.primaryGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(IconPath.photoUpload),
                SizedBox(height: 10.h),
                Text('No Photo available'),
              ],
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: photos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (_, index) {
              final item = photos[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primaryGrey,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.network(item.url ?? '', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        item.caption ?? 'No caption',
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryBlack,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
