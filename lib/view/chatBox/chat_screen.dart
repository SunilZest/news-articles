import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/controller/chat_controller.dart';
import 'package:news/view/chatBox/chat_bubble.dart';
import 'package:news/view/chatBox/chat_input_field.dart';

// import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    // Prevent screenshots when app starts
    // FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.teal,
                  Colors.white,
                ],
              ),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'AskMe',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: Obx(
        () => Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    return ChatBubble(message: message);
                  },
                ),
              ),
              const ChatInputField(),
            ],
          ),
        ),
      ),
    );
  }
}
