import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/router/routes.dart';
import '../../../../../core/utils/assets.dart';
import '../../../bloc/auth_bloc.dart';
import '../../widgets/auth_header.dart';
import 'widgets/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                          title: 'Create Account',
                          subtitle: 'Please fill in the form to continue',
                          logo: Image.asset(
                            Assets.imagesHappyMic,
                            width: 100,
                            height: 90,
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
                          child: SignUpForm(
                            onSignInTap: () {
                              context.pushReplacementNamed(
                                AppRoute.signin.name,
                              );
                            },
                            onSignUp: (userType, email, password, name) async {
                              context.read<AuthBloc>().add(
                                SignUpRequested(
                                  email: email,
                                  password: password,
                                  name: name,
                                  userType: userType,
                                ),
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
    );
  }
}
