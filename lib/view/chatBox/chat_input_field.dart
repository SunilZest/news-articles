import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/controller/chat_controller.dart';

class ChatInputField extends GetView<ChatController> {
  const ChatInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    final TextEditingController messageTextController = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageTextController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 15),
            ),
          ),
          const SizedBox(width: 8.0),
          // IconButton(
          //   icon: const Icon(Icons.send),
          //   onPressed: () {
          //     if (messageTextController.text.isNotEmpty) {
          //       controller.sendMessage(messageTextController.text);
          //       messageTextController.clear();
          //     }
          //   },
          // ),
          Center(
            child: Container(
              height: 50,
               width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                iconSize: 50,
                icon: Image.asset("assets/images/send_icon.png"),
                color: Colors.white,
                onPressed: () {
                      if (messageTextController.text.isNotEmpty) {
                        controller.sendMessage(messageTextController.text);
                        messageTextController.clear();
                      }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
