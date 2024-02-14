import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/widgets/common/avatar.dart';
import 'package:flutter/material.dart';

class ConversationTemplate extends StatelessWidget {
  final Conversation conversation;

  const ConversationTemplate({super.key, required this.conversation});

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
              SpeechBubble(label: conversation.question),
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

                return SpeechBubble(label: option.label, onTap: option.onTap);
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

class SpeechBubble extends StatelessWidget {
  final String label;
  final Function? onTap;

  const SpeechBubble({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(label),
      ),
    );
  }
}
