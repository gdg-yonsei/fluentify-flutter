import 'dart:async';

import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/widgets/common/avatar.dart';
import 'package:fluentify/widgets/common/popper.dart';
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:flutter/material.dart';

class ConversationScaffold extends StatefulWidget {
  final Conversation conversation;

  const ConversationScaffold({super.key, required this.conversation});

  @override
  State<ConversationScaffold> createState() => _ConversationScaffoldState();
}

class _ConversationScaffoldState extends State<ConversationScaffold> {
  bool visible = false;

  Future<void> _show() async {
    setState(() {
      visible = true;
    });

    // Wait until animation ends
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _hide() async {
    setState(() {
      visible = false;
    });

    // Wait until animation ends
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  void initState() {
    super.initState();

    // Animate after initiated
    Timer(const Duration(seconds: 0), _show);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // Animate before disposed
      onPopInvoked: (canPop) async {
        await _hide();

        if (!context.mounted) return;

        Navigator.pop(context);
      },
      child: Column(
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
                Popper(
                  visible: visible,
                  child: SpeechBubble(
                    message: widget.conversation.question.message,
                    edgeLocation: EdgeLocation.top,
                  ),
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
                itemCount: widget.conversation.answers.length,
                itemBuilder: (context, index) {
                  final option = widget.conversation.answers[index];
                  final isLast =
                      index == widget.conversation.answers.length - 1;

                  return Popper(
                    visible: visible,
                    child: SpeechBubble(
                      message: option.message,
                      onTap: () => option.onAnswer?.call(_hide, _show),
                      edgeLocation:
                          isLast ? EdgeLocation.bottom : EdgeLocation.none,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
