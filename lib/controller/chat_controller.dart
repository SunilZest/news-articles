import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:news/model/chat_message.dart';

class ChatController extends GetxController {
  final RxList<ChatMessage> _messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  final String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyDzFFONJsAy3xBL5mGpMYjaFFyZU_3tabY';
  List<ChatMessage> get messages => _messages.reversed.toList();

  Future<void> sendMessage(String message) async {
    try {
      print("callAPI");
      print("message$message");
      isLoading.value = true;

      final newMessage = ChatMessage(
        message: message,
        sender: 'Me', // Replace with actual sender name
        timestamp: DateTime.now(),
        isLoading: true,
      );
      _messages.add(newMessage);

      final dio = Dio(); // Consider using a singleton for Dio instance

      final response = await dio.post(
        _baseUrl,
        data: {
          "contents": [
            {
              "parts": [
                {'text': message}
              ]
            }
          ]
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print("response chat Api ${response.data.toString()}");

      if (response.statusCode == 200) {
        // Parse the response data to extract the text content
        final responseData = response.data;
        final responseText = responseData['candidates'][0]['content']['parts'][0]['text'];

        // Update the message to indicate it's been sent
        newMessage.isLoading = false;
        _messages[_messages.indexOf(newMessage)] = newMessage;

        // Add the response message to the chat list
        final responseMessage = ChatMessage(
          message: responseText,
          sender: 'Bot', // Replace with actual sender name
          timestamp: DateTime.now(),
        );
        _messages.add(responseMessage);
      } else {
        errorMessage.value =
        'Error sending message: ${response.data['error'] ?? 'Unknown error'}';
      }
    } on DioError catch (e) {
      errorMessage.value = 'Error communicating with server: ${e.message}';
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }
}

