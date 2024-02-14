import 'package:fluentify/widgets/common/appbar.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: FluentifyAppBar(canGoBack: true),
      body: SafeArea(
        child: Text('History'),
      ),
    );
  }
}
