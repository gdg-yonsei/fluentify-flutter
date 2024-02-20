import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentify/services/user.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/avatar.dart';
import 'package:fluentify/widgets/common/popper.dart';
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:fluentify/widgets/common/splitter.dart';
import 'package:fluentify/widgets/settings/user_form.dart';
import 'package:flutter/material.dart';

class UserSettingScreen extends StatefulWidget {
  const UserSettingScreen({super.key});

  @override
  State<UserSettingScreen> createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends State<UserSettingScreen> {
  final uid = FirebaseAuth.instance.currentUser?.uid ?? '';

  final nameController = TextEditingController();
  final ageController = TextEditingController();

  bool visible = false;

  Future<void> loadUser() async {
    final user = await UserService.getUser(id: uid);

    setState(() {
      nameController.text = user.name;
      ageController.text = '${user.age}';

      visible = true;
    });
  }

  Future<void> updateUser() async {
    final navigator = Navigator.of(context);

    await UserService.updateUser(
      id: uid,
      name: nameController.text,
      age: int.parse(ageController.text),
    );

    navigator.pop();
  }

  @override
  void initState() {
    super.initState();

    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FluentifyAppBar(),
      body: Splitter(
        padding: 20,
        top: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Avatar(),
            const SizedBox(height: 30),
            Popper(
              visible: visible,
              child: const SpeechBubble(
                message: 'Let me know you!',
                edgeLocation: EdgeLocation.top,
              ),
            ),
          ],
        ),
        bottom: SafeArea(
          child: Column(
            children: [
              Popper(
                visible: visible,
                child: UserForm(
                  nameController: nameController,
                  ageController: ageController,
                ),
              ),
              const SizedBox(height: 20),
              Popper(
                visible: visible,
                child: SpeechBubble(
                  message: 'This is me!',
                  edgeLocation: EdgeLocation.bottom,
                  onTap: () {
                    updateUser();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
