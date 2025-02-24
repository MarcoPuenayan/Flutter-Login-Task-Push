import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final StatelessWidget successScreen;
  final StatelessWidget errorScreen;

  const LoginButton({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.successScreen,
    required this.errorScreen,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  final buttonText = "Login";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _login,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(Size(double.infinity, 50)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      child: Text(buttonText),
    );
  }

  Future<void> _login() async {
    String email = widget.usernameController.text;
    String password = widget.passwordController.text;

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.successScreen),
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget.errorScreen),
      );
    }
  }
}
