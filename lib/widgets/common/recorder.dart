import 'package:flutter/material.dart';

class Recorder extends StatelessWidget {
  final bool isRecording;
  final void Function() onStartRecord;
  final void Function() onFinishRecord;

  const Recorder({
    super.key,
    required this.isRecording,
    required this.onStartRecord,
    required this.onFinishRecord,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isRecording ? Colors.red : Colors.grey,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: isRecording ? onFinishRecord : onStartRecord,
        icon: Icon(
          Icons.mic_outlined,
          color: isRecording ? Colors.red : Colors.grey,
        ),
        iconSize: 40,
        padding: const EdgeInsets.all(20),
      ),
    );
  }
}
