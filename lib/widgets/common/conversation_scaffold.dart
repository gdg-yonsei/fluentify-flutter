import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/widgets/common/avatar.dart';
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:flutter/material.dart';

class ConversationScaffold extends StatelessWidget {
  final Conversation conversation;

  const ConversationScaffold({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Avatar(),
              const SizedBox(height: 30),
              SpeechBubble(
                message: conversation.question,
                edgeLocation: EdgeLocation.top,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(30),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: conversation.answerOptions.length,
              itemBuilder: (context, index) {
                final option = conversation.answerOptions[index];
                final isLast = index == conversation.answerOptions.length - 1;

                return SpeechBubble(
                  message: option.message,
                  onTap: option.onTap,
                  edgeLocation:
                      isLast ? EdgeLocation.bottom : EdgeLocation.none,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
            ),
          ),
        ),
      ],
    );
  }
}
