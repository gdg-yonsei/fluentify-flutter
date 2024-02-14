import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/avatar.dart';
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:flutter/material.dart';

class CaseScreen extends StatefulWidget {
  final String title;

  CaseScreen({super.key, required this.title});

  final List<String> cases = ['Case1', 'Case2', 'Case3', 'Case4'];

  @override
  State<CaseScreen> createState() => _CaseScreenState();
}

class _CaseScreenState extends State<CaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FluentifyAppBar(
        title: Hero(
          tag: widget.title,
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
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
                  SpeechBubble(message: widget.cases[0]),
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
