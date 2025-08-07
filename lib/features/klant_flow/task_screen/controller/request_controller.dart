// ignore_for_file: unnecessary_null_comparison, unused_element, unnecessary_nullable_for_final_variable_declarations, use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/klant_flow/task_screen/model/get_client_invoice.dart';
import 'package:baxton/features/klant_flow/task_screen/model/get_service_request_model.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/beoordelingsverzoek_invoice.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/photo_gallery_screen.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/task_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RequestController extends GetxController {
  // Text controllers
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController postcodecontroller = TextEditingController();
  TextEditingController describecontroller = TextEditingController();
  TextEditingController problemcontroller = TextEditingController();

  // Observable variables
  var selectedDate = ''.obs;
  var selectedTime = ''.obs;
  var selectedImage = Rx<File?>(null);
  var errorMessage = ''.obs;
  var requestId = ''.obs;
  var serviceRequest = Rx<Getservicerequest?>(null);
  var invoice = Rx<Getclientinvoice?>(null);
  var shouldFetchInvoice = true.obs; // Flag to control invoice fetching
  Timer? _statusTimer;
  RxList<File> selectedImages = <File>[].obs;
  RxList<String> imageCaptions = <String>[].obs;

  RxBool showAllImages = false.obs;

  void toggleShowAllImages() {
    showAllImages.value = !showAllImages.value;
  }

  // Simplified image picker method
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      debugPrint('Failed to pick image: $e');
      EasyLoading.showError('Failed to pick image: $e');
    }
  }

  Future<void> pickImagesWithCaptions(BuildContext context) async {
    final List<XFile>? picked = await ImagePicker().pickMultiImage();

    if (picked == null || picked.isEmpty) return;

    final List<File> newImages = [];
    final List<String> newCaptions = [];

    for (var xfile in picked) {
      final File file = File(xfile.path);
      final caption = await _askCaptionDialog(context, file);
      if (caption != null) {
        newImages.add(file);
        newCaptions.add(caption);
      }
    }

    if (newImages.isNotEmpty) {
      selectedImages.addAll(newImages);
      imageCaptions.addAll(newCaptions);
    }
  }

  Future<String?> _askCaptionDialog(BuildContext context, File image) async {
    final TextEditingController controller = TextEditingController();

    return await Get.dialog<String>(
      PopScope(
        canPop: false,
        child: Dialog(
          insetPadding: const EdgeInsets.all(16),
          backgroundColor: AppColors.backgroundColor,
          child: Container(
            padding: const EdgeInsets.all(16),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Voer een bijschrift in',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(image, height: 180, fit: BoxFit.cover),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller,

                  maxLines: 3,
                  style: getTextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  // maxLength: 30,
                  decoration: const InputDecoration(
                    hintText: 'Bijschrift',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.text.trim().isEmpty) {
                        Get.snackbar(
                          'Fout',
                          'Bijschrift is verplicht.',
                          backgroundColor: Colors.red.withValues(alpha: 0.7),
                          colorText: Colors.white,
                        );
                        return;
                      }
                      Get.back(result: controller.text.trim());
                    },
                    child: const Text('Toevoegen'),
                  ),
                ),
                TextButton(
                  onPressed: () => Get.back(result: null),
                  child: const Text('Annuleren'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to submit the form data to the API
  Future<bool> submitRequest(String taskTypeId) async {
    debugPrint('Starting request submission with Task Type ID: $taskTypeId');
    try {
      await EasyLoading.show(status: 'Submitting request...');

      String? token = await AuthService.getToken();
      debugPrint(
        'Retrieved token: ${token != null ? 'Valid token' : 'Null or empty token'}',
      );

      if (token == null || token.isEmpty) {
        debugPrint('Token validation failed: Token is null or empty');
        errorMessage.value = 'Authentication token is missing';
        await EasyLoading.showError(errorMessage.value);
        return false;
      }

      String? formattedDateTime;
      if (selectedDate.value.isNotEmpty && selectedTime.value.isNotEmpty) {
        debugPrint('Selected date and time are not empty');
        final dateParts = selectedDate.value.split('-');
        debugPrint('Parsed selected date: $dateParts');
        if (dateParts.length == 3) {
          try {
            final day = int.parse(dateParts[0]).toString().padLeft(2, '0');
            final month = int.parse(dateParts[1]).toString().padLeft(2, '0');
            final year = int.parse(dateParts[2]);

            if (day.isEmpty || month.isEmpty || year < 2000 || year > 2100) {
              await EasyLoading.showError('Invalid date components');
              await EasyLoading.dismiss();
              return false;
            }

            final timeFormat = DateFormat('h:mm a');
            final parsedTime = timeFormat.parse(selectedTime.value);
            final hour = parsedTime.hour.toString().padLeft(2, '0');
            final minute = parsedTime.minute.toString().padLeft(2, '0');

            formattedDateTime = '$year-$month-${day}T$hour:$minute:00Z';
            debugPrint('Formatted date-time: $formattedDateTime');
          } catch (e) {
            debugPrint('Date parsing error: $e');
            await EasyLoading.showError('Invalid date format');
            await EasyLoading.dismiss();
            return false;
          }
        } else {
          await EasyLoading.showError('Invalid date format');
          await EasyLoading.dismiss();
          return false;
        }
      } else {
        await EasyLoading.showError('Please select both date and time');
        await EasyLoading.dismiss();
        return false;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.clientrequest),
      );

      request.headers['accept'] = '*/*';
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      request.fields['name'] = namecontroller.text;
      request.fields['phoneNumber'] = phonecontroller.text;
      request.fields['email'] = emailcontroller.text;
      request.fields['city'] = citycontroller.text;
      request.fields['postalCode'] = postcodecontroller.text;
      request.fields['locationDescription'] = describecontroller.text;
      request.fields['problemDescription'] = problemcontroller.text;
      request.fields['taskTypeId'] = taskTypeId;
      if (formattedDateTime != null) {
        request.fields['preferredDate'] = formattedDateTime;
        request.fields['preferredTime'] = formattedDateTime;
      }

      if (selectedImages.isNotEmpty &&
          imageCaptions.length == selectedImages.length) {
        // Add all files as 'reqPhoto[]'
        for (final file in selectedImages) {
          final fileExtension = file.path.split('.').last.toLowerCase();
          final mimeType =
              (fileExtension == 'jpg' || fileExtension == 'jpeg')
                  ? 'image/jpeg'
                  : 'image/png';

          request.files.add(
            await http.MultipartFile.fromPath(
              'reqPhoto',
              file.path,
              contentType: MediaType.parse(mimeType),
            ),
          );
        }

        // Join captions with comma and add as one field
        request.fields['reqPhotoCaptions'] = imageCaptions.join(',');
      }

      debugPrint('Sending API request with Task Type ID: $taskTypeId');
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      debugPrint('API response status: ${response.statusCode}');
      debugPrint('API response body: $responseBody');

      await EasyLoading.dismiss();

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final jsonResponse = jsonDecode(responseBody);
          final id = jsonResponse['data']?['id']?.toString();
          if (id != null && id.isNotEmpty) {
            requestId.value = id;
            debugPrint('Request ID extracted: $id');
            await fetchRequestStatus();
            _startPeriodicStatusCheck();
          } else {
            debugPrint('No ID found in response');
            errorMessage.value = 'No request ID returned from the server';
            await EasyLoading.showError(errorMessage.value);
            return false;
          }
        } catch (e) {
          debugPrint('Error parsing response: $e');
          errorMessage.value = 'Failed to parse response';
          await EasyLoading.showError(errorMessage.value);
          return false;
        }
        await EasyLoading.showSuccess('Request submitted successfully');
        return true;
      } else {
        errorMessage.value = 'Failed to submit request: $responseBody';
        await EasyLoading.showError(errorMessage.value);
        return false;
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
      errorMessage.value = 'An error occurred: $e';
      await EasyLoading.showError(errorMessage.value);
      await EasyLoading.dismiss();
      return false;
    }
  }

  // // Method to call the GET API and parse into Getservicerequest
  // Future<void> fetchRequestStatus() async {
  //   if (requestId.value.isEmpty) {
  //     debugPrint('No request ID available for status check');
  //     return;
  //   }

  //   try {
  //     String? token = await AuthService.getToken();
  //     if (token == null || token.isEmpty) {
  //       debugPrint('Token validation failed for GET request');
  //       errorMessage.value = 'Authentication token is missing';
  //       await EasyLoading.showError(errorMessage.value);
  //       return;
  //     }

  //     final response = await http.get(
  //       Uri.parse('${Urls.getservicerequest}${requestId.value}'),
  //       headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
  //     );

  //     debugPrint('GET API response status: ${response.statusCode}');
  //     debugPrint('GET API response body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final jsonResponse = jsonDecode(response.body);
  //       serviceRequest.value = Getservicerequest.fromJson(
  //         jsonResponse,
  //       ); // No 'data' wrapper in GET response
  //       debugPrint(
  //         'Service request updated: ${serviceRequest.value?.id}, Image URL: ${serviceRequest.value?.reqPhoto?.url}',
  //       );
  //       await EasyLoading.showInfo(
  //         'Request status updated: ${serviceRequest.value?.status}',
  //       );
  //     } else {
  //       debugPrint('GET API failed: ${response.body}');
  //       errorMessage.value = 'Failed to fetch request status';
  //       await EasyLoading.showError(errorMessage.value);
  //     }
  //   } catch (e) {
  //     debugPrint('Error in GET request: $e');
  //     errorMessage.value = 'Error fetching request status: $e';
  //     await EasyLoading.showError(errorMessage.value);
  //   }
  // }

  //---------------new method to fetch request status----------------

  Future<void> fetchRequestStatus() async {
    if (requestId.value.isEmpty) {
      debugPrint('No request ID available for status check');
      return;
    }

    try {
      String? token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        debugPrint('Token validation failed for GET request');
        errorMessage.value = 'Authentication token is missing';
        await EasyLoading.showError(errorMessage.value);
        return;
      }

      final response = await http.get(
        Uri.parse('${Urls.getservicerequest}${requestId.value}'),
        headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
      );

      debugPrint('GET API response status: ${response.statusCode}');
      debugPrint('GET API response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        serviceRequest.value = Getservicerequest.fromJson(jsonResponse);

        // Updated debug print to handle reqPhoto as a list
        String imageInfo = 'No images';
        if (serviceRequest.value?.reqPhoto != null &&
            serviceRequest.value!.reqPhoto!.isNotEmpty) {
          imageInfo =
              '${serviceRequest.value!.reqPhoto!.length} images: ${serviceRequest.value!.reqPhoto!.map((photo) => photo.url).join(', ')}';
        }

        debugPrint(
          'Service request updated: ${serviceRequest.value?.id}, Images: $imageInfo',
        );

        // Additional debug for reqPhoto array
        debugPrint('=== reqPhoto Debug in fetchRequestStatus ===');
        debugPrint(
          'reqPhoto is null: ${serviceRequest.value?.reqPhoto == null}',
        );
        if (serviceRequest.value?.reqPhoto != null) {
          debugPrint(
            'reqPhoto length: ${serviceRequest.value!.reqPhoto!.length}',
          );
          for (int i = 0; i < serviceRequest.value!.reqPhoto!.length; i++) {
            debugPrint('Photo $i:');
            debugPrint('  URL: ${serviceRequest.value!.reqPhoto![i].url}');
            debugPrint(
              '  Caption: ${serviceRequest.value!.reqPhoto![i].caption}',
            );
          }
        }
        debugPrint('==========================================');

        await EasyLoading.showInfo(
          'Request status updated: ${serviceRequest.value?.status}',
        );
      } else {
        debugPrint('GET API failed: ${response.body}');
        errorMessage.value = 'Failed to fetch request status';
        await EasyLoading.showError(errorMessage.value);
      }
    } catch (e) {
      debugPrint('Error in GET request: $e');
      errorMessage.value = 'Error fetching request status: $e';
      await EasyLoading.showError(errorMessage.value);
    }
  }

  // Start periodic status checks
  void _startPeriodicStatusCheck() {
    _statusTimer?.cancel();
    _statusTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      debugPrint('Checking request status for ID: ${requestId.value}');
      fetchRequestStatus();
    });
  }

  // Stop periodic status checks
  void stopPeriodicStatusCheck() {
    _statusTimer?.cancel();
    _statusTimer = null;
    debugPrint('Periodic status check stopped');
  }

  // Reset invoice fetching flag
  void resetInvoiceFetching() {
    shouldFetchInvoice.value = true;
  }

  // Stop invoice fetching
  void stopInvoiceFetching() {
    shouldFetchInvoice.value = false;
    debugPrint('Stopped invoice fetching');
  }

  Widget buildImageWidget(BuildContext context, serviceRequest) {
    // Debug print to check reqPhoto data
    debugPrint('=== reqPhoto Debug Info ===');
    debugPrint('reqPhoto is null: ${serviceRequest.reqPhoto == null}');
    if (serviceRequest.reqPhoto != null) {
      debugPrint('reqPhoto length: ${serviceRequest.reqPhoto!.length}');
      for (int i = 0; i < serviceRequest.reqPhoto!.length; i++) {
        debugPrint('Photo $i:');
        debugPrint('  URL: ${serviceRequest.reqPhoto![i].url}');
        debugPrint('  Caption: ${serviceRequest.reqPhoto![i].caption}');
      }
    }
    debugPrint('========================');

    // Check if reqPhoto is null or empty
    if (serviceRequest.reqPhoto == null || serviceRequest.reqPhoto!.isEmpty) {
      debugPrint('No valid photo URLs, showing fallback image');
      EasyLoading.showInfo('No image available');
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(IconPath.image, fit: BoxFit.cover),
      );
    }

    return FutureBuilder<String?>(
      future: AuthService.getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          debugPrint('Waiting for token...');
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          debugPrint('Token fetch error: ${snapshot.error}');
          EasyLoading.showError('Failed to load authentication token');
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(IconPath.image, fit: BoxFit.cover),
          );
        }
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          debugPrint('Token is null or empty');
          EasyLoading.showError('Authentication token is missing');
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(IconPath.image, fit: BoxFit.cover),
          );
        }

        final token = snapshot.data!;
        debugPrint('Token retrieved: ${token.substring(0, 10)}...');

        // If there's only one image, show it directly
        if (serviceRequest.reqPhoto!.length == 1) {
          final photo = serviceRequest.reqPhoto!.first;
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: photo.url,
              httpHeaders: {'Authorization': 'Bearer $token'},
              placeholder:
                  (context, url) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[100],
                    ),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              errorWidget: (context, url, error) {
                debugPrint('Image load error: $error, URL: ${photo.url}');
                EasyLoading.showError('Failed to load image');
                return Image.asset(IconPath.image, fit: BoxFit.cover);
              },
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
            ),
          );
        }

        // For multiple images, show grid layout (2 images side by side)
        return SizedBox(
          height: 150,
          child: Row(
            children: [
              // First image (left side)
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: serviceRequest.reqPhoto![0].url,
                    httpHeaders: {'Authorization': 'Bearer $token'},
                    placeholder:
                        (context, url) => Container(
                          decoration: BoxDecoration(color: Colors.grey[100]),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    errorWidget: (context, url, error) {
                      debugPrint('Image load error for first image: $error');
                      return Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.grey[400],
                            size: 40,
                          ),
                        ),
                      );
                    },
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                  ),
                ),
              ),
              SizedBox(width: 4), // Small gap between images
              // Second image with overlay (right side)
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final token = await AuthService.getToken();
                    if (token != null) {
                      Get.to(
                        () => ImageGalleryScreen(
                          photos: serviceRequest.reqPhoto!,
                          initialIndex: 1,
                          token: token,
                        ),
                      );
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: serviceRequest.reqPhoto![1].url,
                          httpHeaders: {'Authorization': 'Bearer $token'},
                          placeholder:
                              (context, url) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          errorWidget: (context, url, error) {
                            debugPrint(
                              'Image load error for second image: $error',
                            );
                            return Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: Icon(
                                  Icons.error_outline,
                                  color: Colors.grey[400],
                                  size: 40,
                                ),
                              ),
                            );
                          },
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150,
                        ),
                        // Dark overlay with count
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                          ),
                          child: Center(
                            child: Text(
                              '+${serviceRequest.reqPhoto!.length - 1}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Optional: Method to show all images in a dialog or full screen view
  // void _showAllImages(
  //   BuildContext context,
  //   List<ReqPhoto> photos,
  //   String token,
  // ) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         backgroundColor: Colors.black,
  //         child: Container(
  //           height: MediaQuery.of(context).size.height * 0.8,
  //           child: Column(
  //             children: [
  //               // Header with close button
  //               Container(
  //                 padding: EdgeInsets.all(16),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       '${photos.length} Photos',
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                     IconButton(
  //                       onPressed: () => Navigator.of(context).pop(),
  //                       icon: Icon(Icons.close, color: Colors.white),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               // Images in PageView
  //               Expanded(
  //                 child: PageView.builder(
  //                   itemCount: photos.length,
  //                   itemBuilder: (context, index) {
  //                     return Container(
  //                       margin: EdgeInsets.all(8),
  //                       child: Column(
  //                         children: [
  //                           Expanded(
  //                             child: ClipRRect(
  //                               borderRadius: BorderRadius.circular(12),
  //                               child: CachedNetworkImage(
  //                                 imageUrl: photos[index].url,
  //                                 httpHeaders: {
  //                                   'Authorization': 'Bearer $token',
  //                                 },
  //                                 placeholder:
  //                                     (context, url) => Container(
  //                                       color: Colors.grey[900],
  //                                       child: const Center(
  //                                         child: CircularProgressIndicator(
  //                                           color: Colors.white,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                 errorWidget: (context, url, error) {
  //                                   return Container(
  //                                     color: Colors.grey[800],
  //                                     child: Center(
  //                                       child: Column(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.center,
  //                                         children: [
  //                                           Icon(
  //                                             Icons.error_outline,
  //                                             color: Colors.white,
  //                                             size: 40,
  //                                           ),
  //                                           SizedBox(height: 8),
  //                                           Text(
  //                                             'Failed to load image',
  //                                             style: TextStyle(
  //                                               color: Colors.white,
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   );
  //                                 },
  //                                 fit: BoxFit.contain,
  //                                 width: double.infinity,
  //                               ),
  //                             ),
  //                           ),
  //                           // Caption if available
  //                           if (photos[index].caption.isNotEmpty) ...[
  //                             SizedBox(height: 12),
  //                             Container(
  //                               width: double.infinity,
  //                               padding: EdgeInsets.symmetric(
  //                                 horizontal: 16,
  //                                 vertical: 8,
  //                               ),
  //                               decoration: BoxDecoration(
  //                                 color: Colors.grey[900],
  //                                 borderRadius: BorderRadius.circular(8),
  //                               ),
  //                               child: Text(
  //                                 photos[index].caption,
  //                                 style: TextStyle(
  //                                   color: Colors.white,
  //                                   fontSize: 14,
  //                                 ),
  //                                 textAlign: TextAlign.center,
  //                               ),
  //                             ),
  //                           ],
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<bool> cancelRequest(String requestId) async {
    try {
      // Step 1: Get the token
      String? token = await AuthService.getToken();
      debugPrint('Retrieved token: $token');

      if (token == null || token.isEmpty) {
        debugPrint('Error: Authentication token is missing');
        EasyLoading.showError('Authentication token is missing');
        return false;
      }

      // Step 2: Make the PATCH request
      final url =
          'https://freepik.softvenceomega.com/ts/service-request/cancel/$requestId';
      debugPrint('Making PATCH request to: $url');

      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Step 3: Check the response status code
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      // Step 4: Handling success or failure
      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.offAll(TaskScreen);
        debugPrint('Request canceled successfully: $requestId');
        return true;
      } else {
        debugPrint('Failed to cancel request: ${response.body}');
        return false;
      }
    } catch (e) {
      // Step 5: Error handling
      debugPrint('Error during cancellation: $e');
      return false;
    }
  }

  // Show confirmation dialog for cancellation
  Future<bool> showCancelDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Cancel Request"),
              content: Text("Are you sure you want to cancel this request?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pop(false); // Return false if canceled
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Return true if confirmed
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false; // Default to false if dialog is dismissed
  }

  Future<bool> confirmServiceRequest(String requestId) async {
    try {
      String? token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.showError("Authentication token is missing");
        debugPrint("Error: Authentication token is missing");
        return false;
      }

      final confirmServiceUrl =
          'https://freepik.softvenceomega.com/ts/service-request/confirm-service-request/$requestId';

      EasyLoading.show(status: 'Confirming service request...');
      final confirmResponse = await http.post(
        Uri.parse(confirmServiceUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (confirmResponse.statusCode == 200 ||
          confirmResponse.statusCode == 201) {
        EasyLoading.showSuccess('Service request confirmed successfully');
        debugPrint("Service request confirmed successfully.");
        return true;
      } else {
        EasyLoading.showError(
          'Failed to confirm service request: ${confirmResponse.body}',
        );
        debugPrint(
          "Failed to confirm service request: ${confirmResponse.body}",
        );
        return false;
      }
    } catch (e) {
      EasyLoading.showError(
        'Error occurred while confirming service request: $e',
      );
      debugPrint("Error: $e");
      return false;
    }
  }

  Future<void> createInvoice() async {
    try {
      if (serviceRequest.value == null) {
        EasyLoading.showError("No service request data available");
        debugPrint("Error: No service request data available");
        return;
      }

      final request = serviceRequest.value!;
      final payload = {
        'serviceRequestId': request.id,
        'clientId': request.clientProfileId,
        'workerId': request.workerProfileId ?? "",
      };

      String? token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.showError("Authentication token is missing");
        debugPrint("Error: Authentication token is missing");
        return;
      }

      final response = await http.post(
        Uri.parse('https://freepik.softvenceomega.com/ts/invoice/create'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Invoice created successfully');
        debugPrint("Invoice created successfully.");
      } else {
        EasyLoading.showError('Failed to create invoice: ${response.body}');
        debugPrint("Failed to create invoice: ${response.body}");
      }
    } catch (e) {
      EasyLoading.showError('Error occurred while creating invoice: $e');
      debugPrint("Error: $e");
    }
  }

  Future<void> getInvoice() async {
    if (!shouldFetchInvoice.value) {
      debugPrint('Invoice fetching is disabled');
      return;
    }

    try {
      if (serviceRequest.value == null) {
        EasyLoading.showError("No service request data available");
        debugPrint("Error: No service request data available");
        return;
      }

      final request = serviceRequest.value!;
      if (request.invoiceId == null || request.invoiceId.isEmpty) {
        EasyLoading.showError("Invoice ID is missing");
        debugPrint("Error: Invoice ID is missing");
        return;
      }

      String? token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.showError("Authentication token is missing");
        debugPrint("Error: Authentication token is missing");
        return;
      }

      final response = await http.get(
        Uri.parse(
          'https://freepik.softvenceomega.com/ts/invoice/get/${request.invoiceId}',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final invoiceData = getclientinvoiceFromJson(response.body);
        invoice.value = invoiceData; // Store the invoice data
        EasyLoading.showSuccess('Invoice fetched successfully');
        Get.to(() => BetalingsbeheerInvoiceScreen());
      } else {
        EasyLoading.showError('Failed to fetch invoice: ${response.body}');
        debugPrint("Failed to fetch invoice: ${response.body}");
      }
    } catch (e) {
      EasyLoading.showError('Error occurred while fetching invoice: $e');
      debugPrint("Error: $e");
    }
  }

  @override
  void onClose() {
    namecontroller.dispose();
    phonecontroller.dispose();
    emailcontroller.dispose();
    citycontroller.dispose();
    postcodecontroller.dispose();
    describecontroller.dispose();
    problemcontroller.dispose();
    stopPeriodicStatusCheck();
    super.onClose();
  }
}
