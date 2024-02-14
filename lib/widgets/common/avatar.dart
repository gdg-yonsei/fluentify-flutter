import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  const Avatar({super.key});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.sentiment_satisfied_outlined,
      size: 100,
      color: Colors.white,
    );
  }
}
