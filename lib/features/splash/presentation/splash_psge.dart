import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/routes.dart';
import '../../Auth/bloc/auth_bloc.dart';
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
