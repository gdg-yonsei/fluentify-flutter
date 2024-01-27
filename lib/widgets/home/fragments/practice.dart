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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sentiment_satisfied_outlined,
                  size: 100,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Let's practice!"),
            ],
          ),
        ),
      ],
    );
  }
}
