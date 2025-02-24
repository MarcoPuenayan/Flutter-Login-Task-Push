import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/service/auth_service.dart';
import 'package:flutter_firebase_login/utils/injection_container.dart';

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

  final AuthService _authService = injector<AuthService>();

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

    final loggedIn = await _authService.loginWithEmailAndPassword(
      email,
      password,
    );

    if (!mounted) return;
    if (loggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.successScreen),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget.errorScreen),
      );
    }
  }
}
