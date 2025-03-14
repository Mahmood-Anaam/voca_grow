import 'package:flutter/material.dart';
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
  bool _isLoading = false;

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
            AuthSubmitButton(
              text: 'Send Reset Link',
              isLoading: _isLoading,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => _isLoading = true);
                  try {
                    await widget.onResetPassword?.call(_emailController.text);
                  } finally {
                    setState(() => _isLoading = false);
                  }
                }
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
