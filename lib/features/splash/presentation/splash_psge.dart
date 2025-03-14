
import 'package:flutter/material.dart';
import 'widgets/splash_body.dart';

class SplashPsge extends StatelessWidget {
  const SplashPsge({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const SplashBody(),
      ),
    );
  }
}
