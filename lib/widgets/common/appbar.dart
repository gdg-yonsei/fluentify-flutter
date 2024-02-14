import 'package:flutter/material.dart';

class FluentifyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FluentifyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'fluentify',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
    );
  }
}
