class Conversation {
  final String question;
  final List<ConversationAnswerOption> answerOptions;

  Conversation({required this.question, required this.answerOptions});
}

class ConversationAnswerOption {
  final String label;
  final Function? onTap;

  ConversationAnswerOption({required this.label, this.onTap});
}
