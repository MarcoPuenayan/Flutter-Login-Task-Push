import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/ui/screens/error_screen.dart';
import 'package:flutter_firebase_login/ui/screens/success_screen.dart';
import 'package:flutter_firebase_login/ui/widgets/bordered_text_field.dart';
import 'package:flutter_firebase_login/ui/widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final logoPath = "assets/images/3x4_genetics_logo.png";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 50, bottom: 16),
              child: Image.asset(logoPath),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLoginTitle(),
                  const SizedBox(height: 20),
                  BorderedTextField(
                    label: "Email",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    nextFocusNode: _passwordFocusNode,
                  ),
                  const SizedBox(height: 20),
                  BorderedTextField(
                    label: "Password",
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  LoginButton(
                    usernameController: _emailController,
                    passwordController: _passwordController,
                    successScreen: SuccessScreen(),
                    errorScreen: ErrorScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _buildLoginTitle() {
    return Text("Login", style: Theme.of(context).textTheme.headlineMedium);
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
