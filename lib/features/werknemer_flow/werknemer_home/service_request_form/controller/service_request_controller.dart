import 'package:baxton/features/werknemer_flow/werknemer_home/service_request_form/models/service_request_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ServiceRequestController extends GetxController {
  final request = ServiceRequestModel().obs;

  final cities = ['Dhaka', 'Chittagong', 'Khulna', 'Rajshahi'].obs;
  final taskTypes =
      [
        "Schimmelinspecties en -behandelingen", // Mold inspections and treatments
        "Daklekkage opsporen en repareren", // Detect and repair roof leaks
        "Ventilatiesysteem reinigen en controleren", // Clean and inspect ventilation system
        'Vochtproblemen in muren analyseren en oplossen', // Analyze and resolve moisture problems in walls
        'Isolatie van kruipruimtes verbeteren', // improve insulation of crawl spaces
      ].obs;

  final selectedCity = ''.obs;
  final selectedTaskType = ''.obs;
  final selectedPriceType = ''.obs;
  final selectedTime = ''.obs;
  final selectedDate = Rxn<DateTime>();
  final selectedImagePath = ''.obs;
  final capturedImagePath = ''.obs;

  void setTime(String time) => selectedTime.value = time;
  void setDate(DateTime date) => selectedDate.value = date;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }

  Future<void> captureImage() async {
    final capturedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (capturedFile != null) {
      selectedImagePath.value = capturedFile.path;
    }
  }

  void submitRequest() {
    // ignore: avoid_print
    print('Submitting request: ${request.value}');
  }
}
