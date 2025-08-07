import 'package:baxton/features/Admin_flow/instellingen/user_management/model/user_model.dart';
import 'package:baxton/features/Admin_flow/instellingen/user_management/repository/user_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
 
  final UserRepository _repository = UserRepository();
  @override
  void onInit() {
    super.onInit();
    loadUsers(); // ✅ fetch as soon as controller is created
  }

  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  var searchQuery = ''.obs;
  Future<void> loadUsers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repository.fetchAllUsers();
      users.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  List<UserModel> get filteredUsers {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return users;

    return users.where((user) {
      final name = user.name.toLowerCase();
      final email = user.email.toLowerCase();
      final nameStarts = name.startsWith(query);
      final emailStarts = email.startsWith(query);

      return nameStarts || emailStarts;
    }).toList();
  }

  // ✅ Update search query
  void updateSearch(String query) {
    searchQuery.value = query;
  }
}
