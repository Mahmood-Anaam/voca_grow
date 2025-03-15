import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/routes.dart';
import 'widgets/splash_body.dart';

class SplashPsge extends StatelessWidget {
  const SplashPsge({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushReplacementNamed(AppRoute.signin.name);
          },
          child: const Icon(Icons.arrow_forward),
        ),

        body: const SplashBody(),
      ),
    );
  }
}
