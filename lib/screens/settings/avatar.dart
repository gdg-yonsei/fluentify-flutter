import 'package:fluentify/widgets/common/appbar.dart';
import 'package:flutter/material.dart';

class AvatarSettingScreen extends StatelessWidget {
  const AvatarSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: FluentifyAppBar(),
      body: SafeArea(
        child: Text('Avatar settings'),
      ),
    );
  }
}
