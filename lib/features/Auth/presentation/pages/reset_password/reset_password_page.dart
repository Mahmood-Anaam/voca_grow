import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/router/routes.dart';
import '../../../../../core/utils/assets.dart';
import '../../../bloc/auth_bloc.dart';
import '../../widgets/auth_header.dart';
import 'widgets/reset_password_form.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.pushReplacementNamed(AppRoute.home.name);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesBottomPolygon),
                alignment: Alignment.bottomRight,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesTopPolygon),
                  alignment: Alignment.topLeft,
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthHeader(
                            title: 'Reset Password',
                            subtitle:
                                'Enter your email address to receive a password reset link',
                            logo: Image.asset(
                              Assets.imagesHappyMic,
                              width: 100,
                              height: 100,
                            ),
                          ),

                          SizedBox(height: 10),

                          // Main Card
                          Container(
                            constraints: BoxConstraints(maxWidth: 400),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: ResetPasswordForm(
                              onBackTap: () {
                                context.pushReplacementNamed(
                                  AppRoute.signin.name,
                                );
                              },
                              onResetPassword: (email) async {
                                context.read<AuthBloc>().add(
                                  ResetPasswordEvent(email),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
