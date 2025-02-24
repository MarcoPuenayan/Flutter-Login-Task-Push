import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/ui/widgets/logout_button.dart';
import 'package:flutter_firebase_login/ui/widgets/result_banner_widget.dart';

class SuccessScreen extends StatelessWidget {
  final bannerPath = "assets/images/success_banner.png";
  final message = "Welcome Back!";

  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ResultBannerWidget(
                bannerPath: bannerPath,
                icon: Icons.check_circle_outline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 100,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 130),
                  LogoutButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
