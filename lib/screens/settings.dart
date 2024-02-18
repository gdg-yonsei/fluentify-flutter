import 'package:fluentify/widgets/common/appbar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: FluentifyAppBar(),
      body: SafeArea(
        child: Text('Settings'),
      ),
    );
  }
}
