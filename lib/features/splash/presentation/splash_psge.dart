import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow/features/Auth/data/repositories/auth_repository.dart';
import 'package:voca_grow/features/Auth/presentation/pages/signin/signin_page.dart';
import '../../home/presentation/pages/home_psge.dart';
import 'widgets/splash_body.dart';

class SplashPsge extends StatelessWidget {
  const SplashPsge({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = RepositoryProvider.of<AuthRepository>(
      context,
      listen: false,
    );

    Future<User?> getUser() async {
      await Future.delayed(const Duration(seconds: 2));
      return authRepository.getCurrentUser();
    }

    return FutureBuilder<User?>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(child: const Scaffold(body: SplashBody()));
        } else if (snapshot.hasData) {
          return const HomePsge();
        }
        return SigninPage();
      },
    );
  }
}
