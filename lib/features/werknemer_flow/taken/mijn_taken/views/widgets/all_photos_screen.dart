import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllPhotosScreen extends StatelessWidget {
  final List<dynamic> reqPhotos;

  const AllPhotosScreen({super.key, required this.reqPhotos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alle Vereiste Foto\'s (${reqPhotos.length})',
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlack,
              ),
            ),
            SizedBox(height: 16.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reqPhotos.length,
              itemBuilder: (context, index) {
                return _buildFullPhotoItem(reqPhotos[index], index + 1);
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Image.asset(IconPath.arrowBack),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      title: Text(
        "Vereiste Foto's",
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

  Widget _buildFullPhotoItem(dynamic reqPhoto, int photoNumber) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffEBEBEB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo number header
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withValues(alpha:0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Text(
              'Foto $photoNumber',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryGold,
              ),
            ),
          ),

          // Image container with tap to expand
          GestureDetector(
            onTap: () => _showFullScreenImage(reqPhoto),
            child: Container(
              width: double.infinity,
              height: 250.h,
              color: Colors.grey[50],
              child:
                  reqPhoto.url != null && reqPhoto.url.isNotEmpty
                      ? Stack(
                        children: [
                          Image.network(
                            reqPhoto.url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildErrorWidget();
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return _buildLoadingWidget(loadingProgress);
                            },
                          ),
                          // Expand icon overlay
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: EdgeInsets.all(8.sp),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha:0.6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      )
                      : _buildNoImageWidget(),
            ),
          ),

          // Caption section
          if (reqPhoto.caption != null && reqPhoto.caption.isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Beschrijving:',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    reqPhoto.caption,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: const Color(0xff666666),
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.sp),
              child: Text(
                'Geen beschrijving beschikbaar',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image, size: 50.sp, color: Colors.grey[400]),
          SizedBox(height: 12.h),
          Text(
            'Afbeelding niet beschikbaar',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tik om opnieuw te proberen',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget(ImageChunkEvent loadingProgress) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            value:
                loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
            color: AppColors.buttonPrimary,
            strokeWidth: 3,
          ),
          SizedBox(height: 16.h),
          Text(
            'Afbeelding laden...',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoImageWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.photo, size: 50.sp, color: Colors.grey[400]),
          SizedBox(height: 12.h),
          Text(
            'Geen afbeelding beschikbaar',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _showFullScreenImage(dynamic reqPhoto) {
    if (reqPhoto.url == null || reqPhoto.url.isEmpty) return;

    Get.dialog(
      Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            // Full screen image
            Center(
              child: InteractiveViewer(
                child: Image.network(
                  reqPhoto.url,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            size: 60.sp,
                            color: Colors.white70,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Afbeelding kan niet geladen worden',
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              color: Colors.white70,
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
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Close button
            Positioned(
              top: MediaQuery.of(Get.context!).padding.top + 16,
              right: 16,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha:0.6),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 24.sp),
                ),
              ),
            ),

            // Caption overlay (if exists)
            if (reqPhoto.caption != null && reqPhoto.caption.isNotEmpty)
              Positioned(
                bottom: MediaQuery.of(Get.context!).padding.bottom + 20,
                left: 16,
                right: 16,
                child: Container(
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha:0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    reqPhoto.caption,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: Colors.white,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
