import 'dart:async';
import 'dart:developer';

import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/widgets/common/avatar.dart';
import 'package:fluentify/widgets/common/popper.dart';
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ConversationScaffold extends StatefulWidget {
  final Conversation conversation;

  const ConversationScaffold({super.key, required this.conversation});

  @override
  State<ConversationScaffold> createState() => _ConversationScaffoldState();
}

class _ConversationScaffoldState extends State<ConversationScaffold> {
  bool visible = false;

  void withTransition(Function? afterTransition) {
    if (afterTransition == null) return;

    setState(() {
      visible = false;
    });

    Timer(const Duration(milliseconds: 500), () {
      afterTransition();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('built!');

    return VisibilityDetector(
      key: const Key('conversation'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0 && visible == false) {
          setState(() {
            visible = true;
          });
        }
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
                    message: widget.conversation.question,
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
                itemCount: widget.conversation.answerOptions.length,
                itemBuilder: (context, index) {
                  final option = widget.conversation.answerOptions[index];
                  final isLast =
                      index == widget.conversation.answerOptions.length - 1;

                  return Popper(
                    visible: visible,
                    child: SpeechBubble(
                      message: option.message,
                      onTap: () {
                        withTransition(option.onTap);
                      },
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
