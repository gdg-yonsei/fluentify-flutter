import 'dart:async';

import 'package:fluentify/interfaces/evaluation.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/avatar.dart';
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:flutter/material.dart';

class CaseScreen extends StatefulWidget {
  CaseScreen({super.key});

  final List<String> cases = ['Case1', 'Case2', 'Case3', 'Case4'];

  @override
  State<CaseScreen> createState() => _CaseScreenState();
}

class _CaseScreenState extends State<CaseScreen> {
  int caseIndex = 0;
  EvaluationState state = EvaluationState.ready;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      setState(() {
        state = EvaluationState.evaluating;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case EvaluationState.ready:
        return Container(
          alignment: Alignment.center,
          color: Theme.of(context).colorScheme.primary,
          child: Text(
            'Case ${caseIndex + 1}',
            style: const TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.none,
            ),
          ),
        );
      default:
        return Scaffold(
          appBar: const FluentifyAppBar(),
          body: SafeArea(
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
                      SpeechBubble(message: widget.cases[caseIndex]),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(30),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.mic_outlined),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }
}
