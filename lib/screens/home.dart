import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'fluentify',
          style: TextStyle(
            color: Color(0xffffffff),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xff35BAC2),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: const Color(0xff35BAC2),
              child: const Text('상단'),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFFAFAFA),
              child: const Text('하단'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Text('d'), label: 'Pratice'),
          BottomNavigationBarItem(icon: Text('d'), label: 'History'),
          BottomNavigationBarItem(icon: Text('d'), label: 'Settings')
        ],
        elevation: 0,
        backgroundColor: const Color(0xFFFAFAFA),
        selectedItemColor: const Color(0xff35BAC2),
      ),
    );
  }
}
