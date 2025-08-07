import 'package:baxton/features/Admin_flow/admin_home/screens/admin_home_screens.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/klant_flow/bottom_navigationbar/screens/bottom_navigation_ber.dart';
import 'package:baxton/features/role_screen/screen/role_screen.dart';
import 'package:baxton/features/werknemer_flow/bottom_navigation_bar/screens/bottom_navbar.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    navigateAfterDelay();
    super.onInit();
  }

  void navigateAfterDelay() async {
    await Future.delayed(Duration(seconds: 3));
    final token = await AuthService.getToken();
    final roles = await AuthService.getRoles();
    // check token and roles for worker, client, and admin
    if (token != null && token.isNotEmpty && roles.contains('CLIENT')) {
      Get.offAll(() => ClientBottomNavbar());
      return;
    } else if (token != null && token.isNotEmpty && roles.contains('WORKER')) {
      Get.offAll(() => WorkerBottomNavbar());
      return;
    } else if (token != null && token.isNotEmpty && roles.contains('ADMIN')) {
      Get.offAll(() => AdminHomeScreen());
      return;
    } else {
      Get.offAll(() => RoleScreen());
      return;
    }
  }
}
