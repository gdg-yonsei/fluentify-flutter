class Conversation {
  final ConversationQuestion question;
  final List<ConversationAnswer> answers;

  Conversation({required this.question, required this.answers});
}

class ConversationQuestion {
  final String message;

  ConversationQuestion({required this.message});
}

class ConversationAnswer {
  final String message;
  final OnAnswer? onAnswer;

  ConversationAnswer({required this.message, this.onAnswer});
}

typedef OnAnswer = Future<void> Function(
  Future<void> Function() hide,
  Future<void> Function() show,
);
