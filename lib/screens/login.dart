import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> login() async {
    final user = await GoogleSignIn().signIn();

    if (user == null) return;

    final authentication = await user.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              alignment: Alignment.center,
              child: const SafeArea(
                bottom: false,
                child: Text(
                  'fluentify',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: IconButton(
                onPressed: login,
                padding: EdgeInsets.zero,
                highlightColor: Colors.transparent,
                icon: SvgPicture.asset(
                  'assets/image-google-login.svg',
                  height: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
