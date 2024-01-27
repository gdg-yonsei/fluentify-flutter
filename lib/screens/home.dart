import 'package:flutter/material.dart';

import '../widgets/home/fragments/history.dart';
import '../widgets/home/fragments/practice.dart';
import '../widgets/home/fragments/settings.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final List<Widget> _fragments = [
    const PracticeFragment(),
    const HistoryFragment(),
    const SettingsFragment(),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentFragmentIndex = 0;

  void _navigate(int index) {
    setState(() {
      _currentFragmentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'fluentify',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: widget._fragments[_currentFragmentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer_outlined),
            label: 'Pratice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          )
        ],
        currentIndex: _currentFragmentIndex,
        onTap: _navigate,
        elevation: 0,
      ),
    );
  }
}
