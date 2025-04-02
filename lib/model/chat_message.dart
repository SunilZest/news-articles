class ChatMessage {
  final String message;
  final String sender;
  final DateTime timestamp;
  bool isLoading;

  ChatMessage({
    required this.message,
    required this.sender,
    required this.timestamp,
    this.isLoading = false,
  });
}

