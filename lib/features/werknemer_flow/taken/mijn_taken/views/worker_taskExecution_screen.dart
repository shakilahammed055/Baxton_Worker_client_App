// ignore_for_file: file_names, unused_element
import 'dart:convert';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/signature_controller.dart';
import 'package:baxton/features/werknemer_flow/bottom_navigation_bar/screens/bottom_navbar.dart';
import 'package:baxton/features/werknemer_flow/taken/details/controller/task_execution_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/details/view/widget/new_checkList_widget.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/check_list_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/completed_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/confirm_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/note_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/photo_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/service_price_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/upcoming_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/repository/checklist_repository.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/repository/note_repository.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/repository/photo_repository.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/repository/service_price_repository.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/all_photos_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerTaskExecutionScreen extends StatelessWidget {
  final String taskId;
  final UpcomingTaskController controller = Get.find<UpcomingTaskController>();

  final TaskExecutionController taskExecutionController = Get.put(
    TaskExecutionController(),
  );
  final SharedSignatureController signatureController =
      Get.find<SharedSignatureController>();
  final ConfirmedTaskController confirmedTaskController =
      Get.find<ConfirmedTaskController>();
  final CompletedTaskController completedTaskController =
      Get.find<CompletedTaskController>();
  WorkerTaskExecutionScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    final servicePriceController = Get.put(
      ServicePriceController(
        repository: ServicePriceRepository(),
        taskId: taskId,
      ),
    );
    final checklistController = Get.put(
      ChecklistController(
        taskId: taskId,
        checklistRepository: ChecklistRepository(),
      ),
    );
    final photoController = Get.put(
      PhotoController(repository: PhotoRepository(), taskId: taskId),
    );
    final noteController = Get.put(
      NoteController(repository: NoteRepository(), taskId: taskId),
    );

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
              SizedBox(height: 8.h),
              if (data.reqPhoto != null && data.reqPhoto!.isNotEmpty)
                _buildReqPhotoSection(data),
              if (data.reqPhoto != null && data.reqPhoto!.isNotEmpty)
                SizedBox(height: 10.h),
              _buildKlanteninformatieView(data),
              SizedBox(height: 20.h),
              _buildWorkItemsList(controller),
              _buildPaymentType(data),
              SizedBox(height: 10.h),
              _buildAddWorkButton(context, servicePriceController),
              SizedBox(height: 32.h),
              _buildProgressSection(controller),
              SizedBox(height: 30.h),
              _buildChecklistSection(context, controller, checklistController),
              SizedBox(height: 40.h),
              // _buildBeforePhotosSection(),
              _buildBeforePhotosSection(controller, photoController),
              SizedBox(height: 40.h),
              _buildAfterPhotosSection(controller, photoController),
              SizedBox(height: 40.h),
              _buildSignatureSection(),
              SizedBox(height: 30.h),
              _buildNotesSection(noteController),
              SizedBox(height: 40.h),
              _buildActionButtons(noteController),
              SizedBox(height: 40.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildReqPhotoSection(dynamic data) {
    final List<dynamic> reqPhotos = data.reqPhoto!;
    final int totalPhotos = reqPhotos.length;
    final List<dynamic> displayPhotos =
        totalPhotos > 2 ? reqPhotos.take(2).toList() : reqPhotos;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffEBEBEB)),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vereiste Foto\'s',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (totalPhotos > 2)
                GestureDetector(
                  onTap: () => _navigateToAllPhotos(reqPhotos),
                  child: Text(
                    'Bekijk alles ($totalPhotos)',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: AppColors.primaryGold,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          if (totalPhotos == 1)
            _buildPhotoItem(displayPhotos[0], false)
          else if (totalPhotos == 2)
            Row(
              children: [
                Expanded(child: _buildGridPhotoItem(displayPhotos[0], false)),
                SizedBox(width: 8.w),
                Expanded(child: _buildGridPhotoItem(displayPhotos[1], false)),
              ],
            )
          else if (totalPhotos > 2)
            Row(
              children: [
                Expanded(child: _buildGridPhotoItem(displayPhotos[0], false)),
                SizedBox(width: 8.w),
                Expanded(
                  child: _buildGridPhotoItem(
                    displayPhotos[1],
                    true,
                    totalPhotos - 2,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPhotoItem(
    dynamic reqPhoto,
    bool showOverlay, [
    int? remainingCount,
  ]) {
    return GestureDetector(
      onTap:
          showOverlay
              ? () => _navigateToAllPhotos(
                controller.taskDetailsModel.value!.reqPhoto!,
              )
              : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xffF0F0F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Container(
                width: double.infinity,
                height: 200.h,
                color: Colors.grey[100],
                child: Stack(
                  children: [
                    reqPhoto.url != null && reqPhoto.url.isNotEmpty
                        ? Image.network(
                          reqPhoto.url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.broken_image,
                                    size: 40.sp,
                                    color: Colors.grey[400],
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Afbeelding niet beschikbaar',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                color: AppColors.buttonPrimary,
                              ),
                            );
                          },
                        )
                        : Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo,
                                size: 40.sp,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Geen afbeelding',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                    // Overlay for additional photos
                    if (showOverlay && remainingCount != null)
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha:0.6),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '+$remainingCount',
                                style: GoogleFonts.poppins(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'meer foto\'s',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Caption container
            if (!showOverlay &&
                reqPhoto.caption != null &&
                reqPhoto.caption.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.sp),
                decoration: const BoxDecoration(
                  color: Color(0xffF8F9FA),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  reqPhoto.caption,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: const Color(0xff666666),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridPhotoItem(
    dynamic reqPhoto,
    bool showOverlay, [
    int? remainingCount,
  ]) {
    return GestureDetector(
      onTap:
          showOverlay
              ? () => _navigateToAllPhotos(
                controller.taskDetailsModel.value!.reqPhoto!,
              )
              : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xffF0F0F0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 120.h,
            color: Colors.grey[100],
            child: Stack(
              children: [
                reqPhoto.url != null && reqPhoto.url.isNotEmpty
                    ? Image.network(
                      reqPhoto.url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.broken_image,
                            size: 30.sp,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                            color: AppColors.buttonPrimary,
                          ),
                        );
                      },
                    )
                    : Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.photo,
                        size: 30.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                // Overlay for additional photos
                if (showOverlay && remainingCount != null)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha:0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '+$remainingCount',
                            style: GoogleFonts.poppins(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'meer',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToAllPhotos(List<dynamic> reqPhotos) {
    Get.to(
      () => AllPhotosScreen(reqPhotos: reqPhotos),
      transition: Transition.leftToRight,
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

  Widget _buildKlanteninformatieView(dynamic data) {
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
            'Klanteninformatie',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildInfoRow('Naam', data.clientProfile?.userName ?? 'No data'),
          SizedBox(height: 5.h),
          _buildInfoRow('Telefoonnummer', data.phoneNumber ?? 'No data'),
          SizedBox(height: 5.h),
          _buildInfoRow(
            'Gewenste datum',
            data.preferredDate?.split('T')[0] ?? 'No data',
          ),
          SizedBox(height: 5.h),
          _buildInfoRow(
            'Gewenste tijd',
            data.preferredTime != null
                ? data.preferredTime!.split('T')[1].substring(0, 5)
                : 'No data',
          ),
          SizedBox(height: 5.h),
          _buildInfoRow('Taaktype', data.taskTypeName ?? 'No data'),
        ],
      ),
    );
  }

  Widget _buildPaymentType(dynamic data) {
    return Container(
      width: double.infinity,
      height: 50.h,
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xffFBF6E6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: _buildInfoRow(
        'Totaal',
        '\$${data.basePrice?.toStringAsFixed(2) ?? '0.00'}',
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 14.sp, color: Color(0xff666666)),
        ),
        SizedBox(width: 4.w),
        Text(value),
      ],
    );
  }

  Widget _buildWorkItemsList(UpcomingTaskController controller) {
    return Obx(() {
      final details = controller.taskDetailsModel.value;
      final items = details?.serviceDetails ?? [];

      if (items.isEmpty) {
        return const Text('Geen werk toegevoegd.');
      }

      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            // margin: const EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.serviceName ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '\$ ${item.servicePrice?.toStringAsFixed(2) ?? '0.00'}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildAddWorkButton(
    BuildContext context,
    ServicePriceController controller,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _showWorkDialog(context, controller),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryBlue,
          foregroundColor: AppColors.primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27),
          ),
          side: const BorderSide(color: AppColors.secondaryBlue),
        ),
        child: Text(
          'Toevoegen   +',
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryBlue,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection(UpcomingTaskController controller) {
    return Obx(() {
      final details = controller.taskDetailsModel.value;
      final tasks = details?.tasks ?? [];

      if (tasks.isEmpty) {
        return const Text('Nog geen checklist items.');
      }

      final total = tasks.length;
      final doneCount = tasks.where((t) => t.done == true).length;
      final progress = total > 0 ? doneCount / total : 0.0;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jouw voortgang',
            style: getTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.grey4,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              '${(progress * 100).toStringAsFixed(0)}% Voltooid',

              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryCyan,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: AppColors.secondaryWhite,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 8),
        ],
      );
    });
  }

  Widget _buildChecklistSection(
    BuildContext context,
    UpcomingTaskController upcomingTaskController,
    ChecklistController checkListController,
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

        // ✅ Add new checklist item
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _showChecklistDialog(context, checkListController),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(51),
              ),
              side: const BorderSide(color: AppColors.secondaryBlue),
            ),
            child: const Text(
              'Checklist +',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryWhite,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // ✅ show checklist items from API (taskDetailsModel.tasks)
        Obx(() {
          final details = upcomingTaskController.taskDetailsModel.value;
          final items = details?.tasks ?? [];

          if (items.isEmpty) {
            return const Text('Geen checklist items.');
          }

          return Column(
            children:
                items.map((item) {
                  return NewChecklistWidget(
                    item: item,
                    onChanged: (val) {
                      if (val == null) return;

                      // ✅ call your controller here
                      checkListController.toggleChecklistDone(item.id!, val);
                    },
                  );
                }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildBeforePhotosSection(
    UpcomingTaskController upcomingTaskController,
    PhotoController photoController,
  ) {
    return Obx(() {
      final beforePhotos =
          upcomingTaskController.taskDetailsModel.value?.beforePhoto ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upload foto's voordat je aan je werk begint",
            style: getTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryBlack,
            ),
          ),
          const SizedBox(height: 20),
          _buildPhotoUploadSectionView(
            onTap: () async => await photoController.pickBeforePhoto(),
            buttonText: "Voor Foto",
            photos: beforePhotos,
          ),
        ],
      );
    });
  }

  Widget _buildAfterPhotosSection(
    UpcomingTaskController upcomingTaskController,
    PhotoController photoController,
  ) {
    return Obx(() {
      final afterPhotos =
          upcomingTaskController.taskDetailsModel.value?.afterPhoto ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upload foto's nadat je je werk hebt voltooid",
            style: getTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryBlack,
            ),
          ),
          const SizedBox(height: 20),
          _buildPhotoUploadSectionView(
            onTap: () async => await photoController.pickAfterPhoto(),
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
                        item.caption ?? '',
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

  Widget _buildSignatureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Handtekening van de klant",
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 44,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              backgroundColor: AppColors.secondaryBlue,
              side: const BorderSide(color: AppColors.primaryBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(27),
              ),
            ),
            onPressed: () {
              // Handle signature request
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(IconPath.pen),
                Text(
                  "Vraag om de handtekening van de klant",
                  style: getTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Obx(() {
            if (signatureController.signatureBase64.value.isEmpty) {
              return const Text("No signature available yet.");
            } else {
              final image = base64Decode(
                signatureController.signatureBase64.value,
              );
              return Column(
                children: [
                  const Text("Received Signature:"),
                  const SizedBox(height: 10),
                  Image.memory(image, height: 200),
                ],
              );
            }
          }),
        ),
      ],
    );
  }

  Widget _buildNotesSection(NoteController noteController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Note",
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: 3,
          controller: noteController.noteTextController,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    );
  }

  Widget _buildActionButtons(NoteController noteController) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              side: const BorderSide(color: AppColors.primaryBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(62),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Taak Pauzeren',
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              final noteText = noteController.noteTextController.text.trim();

              if (noteText.isEmpty) {
                Get.snackbar(
                  'Fout',
                  'Voer een notitie in voordat u de taak voltooit.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.withValues(alpha: 0.8),
                  colorText: Colors.white,
                );
                return;
              }
              await noteController.completeTaskWithNote(
                noteController.noteTextController.text,
              );

              await confirmedTaskController.loadConfirmedTasks();
              await completedTaskController.loadConfirmedTasks();
              noteController.noteTextController.clear();

              Get.to(() => WorkerBottomNavbar());
            },

            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              backgroundColor: AppColors.primaryBlue,
              side: const BorderSide(color: AppColors.formFieldBorderColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(62),
              ),
            ),
            child: Text(
              'Taak voltooien',
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryWhite,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Dialog Functions
  void _showWorkDialog(
    BuildContext context,
    ServicePriceController controller,
  ) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.primaryWhite,
        insetPadding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primaryWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Prijs instellen',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryBlack,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 41,
                      child: TextFormField(
                        controller: controller.serviceNameController,
                        decoration: const InputDecoration(
                          hintText: 'Dient',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.formFieldBorderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.formFieldBorderColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 41,
                      child: TextFormField(
                        controller: controller.servicePriceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: '0.00',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.formFieldBorderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.formFieldBorderColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(51),
                    ),
                  ),
                  onPressed: () async {
                    await controller
                        .addWorkItem(); // uses your ServicePriceController
                    Get.back();
                  },
                  child: Text(
                    'Wijzigingen opslaan',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChecklistDialog(
    BuildContext context,
    ChecklistController checkListcontroller,
  ) {
    final TextEditingController taskController = TextEditingController();

    Get.dialog(
      Dialog(
        backgroundColor: AppColors.primaryWhite,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Taak',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  maxLines: 3,
                  controller: taskController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: AppColors.secondaryWhite),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: AppColors.secondaryWhite),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final text = taskController.text.trim();
                      if (text.isEmpty) {
                        EasyLoading.showError('Voer een taak in');
                        return;
                      }

                      await checkListcontroller.addChecklistItem(text);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(51),
                      ),
                    ),
                    child: Text(
                      'Toevoegen',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTaskCompletion() {
    Get.dialog(
      AlertDialog(
        title: const Text('Taak Voltooien'),
        content: const Text('Weet je zeker dat je deze taak wilt voltooien?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Annuleren'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Go back to previous screen
              Get.snackbar(
                'Succes',
                'Taak succesvol voltooid!',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
            ),
            child: const Text(
              'Voltooien',
              style: TextStyle(color: AppColors.primaryWhite),
            ),
          ),
        ],
      ),
    );
  }
}
