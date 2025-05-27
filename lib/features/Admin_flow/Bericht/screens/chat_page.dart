import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
import 'package:baxton/features/klant_flow/message_screen/controller/chat_controller.dart';
import 'package:baxton/features/klant_flow/message_screen/screens/single_page_chat.dart';
import 'package:baxton/features/klant_flow/message_screen/widgets/custon_chatlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BerichtMessageScreen extends StatelessWidget {
  BerichtMessageScreen({super.key});

  final ChatController spChatController = Get.put(ChatController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      key: _scaffoldKey,
      drawer: Navbar(),
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Image.asset(IconPath.notes),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Chatten",
          style: getTextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: spChatController.chats.length,
          itemBuilder: (context, index) {
            final chat = spChatController.chats[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => SinglePageChat(chat: chat));
              },
              child: CustomChatList(
                imagePath: chat['image'] ?? '',
                name: chat['name'] ?? '',
                lastMessage: chat['message'] ?? '',
                time: chat['time'] ?? '',
              ),
            );
          },
        ),
      ),
    );
  }
}
