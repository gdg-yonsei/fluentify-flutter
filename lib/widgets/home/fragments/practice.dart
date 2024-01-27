import 'package:flutter/material.dart';

class PracticeFragment extends StatefulWidget {
  const PracticeFragment({super.key});

  @override
  State<PracticeFragment> createState() => _PracticeFragmentState();
}

class _PracticeFragmentState extends State<PracticeFragment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            child: const Text('상단'),
          ),
        ),
        Expanded(
          child: Container(
            child: const Text('하단'),
          ),
        ),
      ],
    );
  }
}
