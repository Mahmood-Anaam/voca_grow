import 'package:flutter/material.dart';
import '../../../widgets/auth_form_field.dart';
import '../../../widgets/auth_submit_button.dart';

class SignInForm extends StatefulWidget {
  final Function(String email, String password)? onSignIn;
  final Function()? onSignUpTap;
  final Function()? onForgotPasswordTap;

  const SignInForm({
    super.key,
    this.onSignIn,
    this.onSignUpTap,
    this.onForgotPasswordTap,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            const SizedBox(height: 20),
            AuthFormField(
              controller: _passwordController,
              hintText: 'Password',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline,
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: widget.onForgotPasswordTap,
              child: Text('Forgot Password?'),
            ),
            const SizedBox(height: 10),
            AuthSubmitButton(
              text: 'Sign In',
              isLoading: _isLoading,

              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => _isLoading = true);
                  try {
                    await widget.onSignIn?.call(
                      _emailController.text,
                      _passwordController.text,
                    );
                  } finally {
                    setState(() => _isLoading = false);
                  }
                }
              },
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.grey.shade600),
                ),
                TextButton(
                  onPressed: widget.onSignUpTap,
                  style: Theme.of(context).textButtonTheme.style?.copyWith(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 0),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
