import 'package:flutter/material.dart';
import 'package:record/record.dart';

class Recorder extends StatefulWidget {
  final AudioRecorder recorder = AudioRecorder();

  final void Function()? onStartRecord;
  final void Function(String audioPath)? onFinishRecord;
  final void Function()? onPermissionDenied;

  Recorder({
    super.key,
    this.onStartRecord,
    this.onFinishRecord,
    this.onPermissionDenied,
  });

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  bool isRecording = false;

  @override
  void initState() {
    super.initState();

    widget.recorder.hasPermission().then((hasPermission) {
      if (!hasPermission) {
        widget.onPermissionDenied?.call();
      }
    });
  }

  void startRecord() async {
    await widget.recorder.start(
      const RecordConfig(encoder: AudioEncoder.wav),
      path: 'sample.wav',
    );

    setState(() {
      isRecording = true;
    });

    widget.onStartRecord?.call();
  }

  void finishRecord() async {
    final audioPath = await widget.recorder.stop();

    if (audioPath == null) return;

    setState(() {
      isRecording = false;
    });

    widget.onFinishRecord?.call(audioPath);
  }

  @override
  void dispose() {
    widget.recorder.dispose();

    super.dispose();
  }

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
        onPressed: isRecording ? finishRecord : startRecord,
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
