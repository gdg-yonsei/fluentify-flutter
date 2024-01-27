import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fluentify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF35BAC2),
          primary: const Color(0xFF35BAC2),
          secondary: const Color(0xFF35BAC2),
          background: const Color(0xFFFAFAFA),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
