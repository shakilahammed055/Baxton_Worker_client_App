import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/bottom_navigation_bar/screens/bottom_navbar.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/upcoming_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/all_photos_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SetPriceTaskDetails extends StatelessWidget {
  SetPriceTaskDetails({super.key});
  final UpcomingTaskController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: _buildAppBar(),
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
              SizedBox(height: 10.h),
              _buildPaymentType(data),
              SizedBox(height: 40.h),
              _buildPriceTextField(),
              SizedBox(height: 40.h),
              _buildIndienenButton(),
            ],
          ),
        );
      }),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          controller.fetchNonSetPriceTasks();
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
        "Stel de Prijzen In",
        style: getTextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryBlack,
        ),
      ),
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.primaryBlack),
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
            data.name ?? '',
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
                          color: Colors.black.withValues(alpha: 0.6),
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
                      color: Colors.black.withValues(alpha: 0.6),
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

  Widget _buildKlanteninformatieView(data) {
    // ✅ Determine naam (prefer clientProfile, else adminProfile)
    final String naam =
        data.clientProfile != null
            ? (data.clientProfile!.userName ?? 'No data')
            : (data.adminProfile?.user?.name ?? 'No data');

    // ✅ Determine telefoon (prefer clientProfile phoneNumber, else adminProfile phone)
    final String telefoon =
        data.clientProfile != null
            ? (data.phoneNumber ?? 'No data')
            : (data.adminProfile?.user?.phone ?? 'No data');

    // ✅ Determine email (optional if you want to show it)
    final String email =
        data.clientProfile != null
            ? (data.email ?? 'No data')
            : (data.adminProfile?.user?.email ?? 'No data');

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffEBEBEB)),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(15.sp),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Klanteninformatie',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildInfoRow('Naam', naam),
          SizedBox(height: 5.h),
          _buildInfoRow('Telefoonnummer', telefoon),
          SizedBox(height: 5.h),
          _buildInfoRow('Email', email),
          SizedBox(height: 5.h),
          _buildInfoRow(
            'Gewenste datum',
            data.preferredDate?.split('T')[0] ?? 'No data',
          ),
        ],
      ),
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
        data.paymentType ?? 'No payment type',
        style: GoogleFonts.roboto(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryGold,
        ),
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

  Widget _buildIndienenButton() {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: () async {
          final id = controller.taskDetailsModel.value?.id ?? '';
          final priceText = controller.setPriceController.text.trim();

          if (id.isEmpty || priceText.isEmpty) {
            debugPrint('⚠️ Missing id or price');
            Get.snackbar(
              'Foutmelding',
              'Voer een geldige prijs in voordat u indient.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.redAccent.withValues(alpha: 0.9),
              colorText: Colors.white,
              margin: const EdgeInsets.all(12),
              borderRadius: 12,
              duration: const Duration(seconds: 3),
              icon: const Icon(Icons.error_outline, color: Colors.white),
            );
            return;
          }

          final price = double.tryParse(priceText);
          if (price == null) {
            debugPrint('⚠️ Invalid price input');
            return;
          }

          debugPrint('🟢 [submitPrice] Submitting price...');
          try {
            final updated = await controller.upcomingTaskRepository.setPrice(
              id,
              price,
            );
            controller.taskDetailsModel.value = updated;
            debugPrint('✅ [submitPrice] Price updated: ${updated.basePrice}');

            // 👉 Navigate to another screen after success
            // Get.to(() => WorkerTaskExecutionScreen());
            Get.to(() => WorkerBottomNavbar());

            Get.snackbar('set price', 'sucessfully Updated');
            controller.setPriceController.clear();
          } catch (e) {
            debugPrint('❌ [submitPrice] Error: $e');
            controller.setPriceController.clear();
          }
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          'Indienen',
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhite,
          ),
        ),
      ),
    );
  }

  Widget _buildPriceTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stel een Prijs In',
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(51, 51, 51, 1),
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller.setPriceController,
          decoration: InputDecoration(
            hintText: 'Voer prijs in',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Color(0xff78828A)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Color(0xff78828A)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: AppColors.buttonPrimary),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}
