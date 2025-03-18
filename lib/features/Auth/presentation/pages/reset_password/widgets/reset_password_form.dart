import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/router/routes.dart';
import '../../../../bloc/auth_bloc.dart';
import '../../../widgets/auth_form_field.dart';
import '../../../widgets/auth_submit_button.dart';

class ResetPasswordForm extends StatefulWidget {
  final Function(String email)? onResetPassword;
  final Function()? onBackTap;
  const ResetPasswordForm({super.key, this.onResetPassword, this.onBackTap});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            AuthFormField(
              controller: _emailController,
              hintText: 'Email',
              labelText: 'Email',
              prefixIcon: Icons.email_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  context.pushReplacementNamed(AppRoute.signin.name);
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return AuthSubmitButton(
                  text: 'Send Reset Link',
                  isLoading: state is AuthLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget.onResetPassword?.call(_emailController.text);
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: widget.onBackTap,
              child: Text('Back to Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
