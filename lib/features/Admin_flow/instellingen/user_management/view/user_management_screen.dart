import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/instellingen/user_management/controller/user_controller.dart';
import 'package:baxton/features/Admin_flow/instellingen/user_management/widget/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserManagementScreen extends StatelessWidget {
  final UserController userManagementController = Get.put(UserController());

  UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Gebruikersbeheer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.blue,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(51),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Nieuwe gebruiker toevoegen'),
                    SizedBox(width: 8),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ),

            // Search Bar and Filer Option
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        userManagementController.updateSearch(value);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12.0,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(IconPath.search),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.borderColor2),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Image.asset(IconPath.filter, height: 28, width: 28),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (userManagementController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                final users = userManagementController.filteredUsers;
                if (userManagementController.users.isEmpty) {
                  return const Center(child: Text('Geen gebruikers gevonden.'));
                }

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return UserTile(user: user);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
