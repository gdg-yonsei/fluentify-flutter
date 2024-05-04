import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/screens/confirmation.dart';
import 'package:fluentify/screens/selection/topic.dart';
import 'package:fluentify/screens/settings/index.dart';
import 'package:fluentify/services/user.dart';
import 'package:fluentify/utils/route.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final uid = FirebaseAuth.instance.currentUser?.uid ?? '';

  String? userName;
  bool isAssistiveDeviceConfirmable = true;

  Future<void> loadUser() async {
    final user = await UserService.getUser(id: uid);

    setState(() {
      userName = user.name;
    });
  }

  Future<void> checkAssistiveDeviceConfirmable() async {
    final isAssistiveDeviceConfirmable =
        await UserService.checkAssistiveDeviceConfirmable();

    setState(() {
      this.isAssistiveDeviceConfirmable = isAssistiveDeviceConfirmable;
    });
  }

  Conversation _generateConversation(BuildContext context) {
    final greeting = userName != null ? 'Hi, $userName!\n' : '';

    return Conversation(
      question: ConversationQuestion(
        message: '${greeting}What are we gonna do today?',
      ),
      answers: [
        ConversationAnswer(
          message: "Let's practice!",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            await navigator.push(
              generateRoute(
                isAssistiveDeviceConfirmable
                    ? const ConfirmationScreen()
                    : const TopicSelectScreen(),
                transitionType: TransitionType.none,
              ),
            );
            await show();
          },
        ),
        ConversationAnswer(
          message: "I want to configure this app.",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            await navigator.push(
              generateRoute(
                const SettingsScreen(),
                transitionType: TransitionType.none,
              ),
            );
            await show();
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    checkAssistiveDeviceConfirmable();

    return PopScope(
      onPopInvoked: (canPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: const FluentifyAppBar(),
        body: SafeArea(
          child: ConversationScaffold(
            conversation: _generateConversation(context),
          ),
        ),
      ),
    );
  }
}
