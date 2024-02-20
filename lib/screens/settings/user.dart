import 'package:fluentify/widgets/common/appbar.dart';
import 'package:flutter/material.dart';

class UserSettingScreen extends StatelessWidget {
  const UserSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: FluentifyAppBar(),
      body: SafeArea(
        child: Text('User settings'),
      ),
    );
  }
}
