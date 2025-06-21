import 'package:baxton/features/Admin_flow/authentication/screens/admin_login_screen.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/admin_home_screens.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer/views/medewerkerbeheer_screen.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/views/task_manager_screen.dart';
import 'package:baxton/features/klant_flow/profile_setup/screen/klant_profile_setup.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/request_screen.dart';
import 'package:baxton/features/werknemer_flow/authentication/views/change_password_screen.dart';
import 'package:baxton/features/werknemer_flow/authentication/views/forget_password_otp_screen.dart';
import 'package:baxton/features/werknemer_flow/authentication/views/forget_password_screen.dart';
import 'package:baxton/features/werknemer_flow/onboarding/view/werknemer_onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:baxton/features/klant_flow/authentication/screens/login_screen.dart';
import 'package:baxton/features/klant_flow/authentication/screens/signup_screen.dart';
import 'package:baxton/features/klant_flow/bottom_navigationbar/screens/bottom_navigation_ber.dart';
import 'package:baxton/features/role_screen/screen/role_screen.dart';
import 'package:baxton/features/splash_screen/screen/splash_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String rolescreen = "/rolescreen";
  static String loginscreen = "/loginscreen";
  static String signupScreen = "/signupScreen";
  static String bottomnavbar = "/bottomnavbar";
  static String onboardingScreen = "/onboardingScreen";
  static String wonboardingScreen = "/wonboardingScreen";
  static String wlogingScreen = "/wlogingScreen";
  static String servemescreen = "/servemescreen";
  static String adminloginscreen = "/adminloginscreen";
  static String adminhomescreen = "/adminhomescreen";
  static String taskManagerScreen = "/taskManagerScreen";
  static String medewerkerbeheerscreen = "/medewerkerbeheerscreen";
  static String changePassword = "/changePassword";
  static String forgetpasswordscreen = "/forgetpasswordscreen";
  static String forgetpasswordOtpScreen = "/forgetpasswordOtpScreen";
  static String klantprofilesetup = "/klantprofilesetup";

  static String getLoginScreen() => splashScreen;
  static String getrolescreen() => rolescreen;
  static String getloginscreen() => loginscreen;
  static String getsignupScreen() => signupScreen;
  static String getbottomnavbar() => bottomnavbar;
  static String getOnboardingScreen() => onboardingScreen;
  static String getadminloginscreen() => adminloginscreen;
  static String getadminhomescreen() => adminhomescreen;
  static String getWLoginScreen() => wlogingScreen;
  static String getservemescreen() => servemescreen;
  static String getTaskManagerScreen() => taskManagerScreen;
  static String getmedewerkerbeheerscreen() => medewerkerbeheerscreen;
  static String getchangePassword() => changePassword;
  static String getforgetpasswordscreen() => forgetpasswordscreen;
  static String getforgetpasswordOtpScreen() => forgetpasswordOtpScreen;
  static String getklantprofilesetup() => klantprofilesetup;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: rolescreen, page: () => const RoleScreen()),
    GetPage(name: loginscreen, page: () => LoginScreen()),
    GetPage(name: signupScreen, page: () => SignupScreen()),
    GetPage(name: bottomnavbar, page: () => BottomNavbar()),
    GetPage(name: onboardingScreen, page: () => WOnbScreen()),
    //GetPage(name: wlogingScreen, page: () => WLoginScreen()),
    GetPage(name: servemescreen, page: () => RequestScreen()),
    GetPage(name: adminloginscreen, page: () => AdminLoginScreen()),
    GetPage(name: adminhomescreen, page: () => AdminHomeScreen()),
    GetPage(name: taskManagerScreen, page: () => TaskManagerScreen()),
    GetPage(name: medewerkerbeheerscreen, page: () => MedewerkerbeheerScreen()),
    GetPage(name: changePassword, page: () => ChangePassword()),
    GetPage(name: forgetpasswordscreen, page: () => ForgetPasswordScreen()),
    GetPage(name: forgetpasswordOtpScreen, page: () => ForgetPasswordOtpScreen()),
    GetPage(name: klantprofilesetup, page: () => KlantProfileSetup()),
  ];
}
