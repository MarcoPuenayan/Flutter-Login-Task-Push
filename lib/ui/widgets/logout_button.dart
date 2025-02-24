import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/ui/screens/login_screen.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  final buttonText = "Logout";

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _logout,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(Size(double.infinity, 50)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      child: Text(widget.buttonText),
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
