import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/services/user.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class ConfirmationSettingScreen extends StatelessWidget {
  const ConfirmationSettingScreen({super.key});

  Conversation _generateConversation(BuildContext context) {
    return Conversation(
      question: ConversationQuestion(
          message:
              "Is it okay to check if you wear a hearing aid or a cochlea implant before starting practicing?"),
      answers: [
        ConversationAnswer(
          message: "Yes, please notify me!",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            UserService.updateAssistiveDeviceConfirmable(true);

            await hide();
            navigator.pop();
          },
        ),
        ConversationAnswer(
          message: "No, it's okay.",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            UserService.updateAssistiveDeviceConfirmable(false);

            await hide();
            navigator.pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FluentifyAppBar(),
      body: SafeArea(
        child: ConversationScaffold(
          conversation: _generateConversation(context),
        ),
      ),
    );
  }
}
