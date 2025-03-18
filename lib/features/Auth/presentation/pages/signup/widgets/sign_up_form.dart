import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow/features/Auth/data/models/models.dart';
import '../../../../bloc/auth_bloc.dart';
import '../../../widgets/auth_form_field.dart';
import '../../../widgets/auth_submit_button.dart';

class SignUpForm extends StatefulWidget {
  final Function(UserType userType, String email, String password, String name)?
  onSignUp;
  final VoidCallback? onSignInTap;

  const SignUpForm({super.key, this.onSignUp, this.onSignInTap});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  UserType _userType = UserType.parent;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            // dropdown usertype
            DropdownButtonFormField<UserType>(
              value: _userType,
              icon: Icon(Icons.merge_type),

              items: const [
                DropdownMenuItem<UserType>(
                  value: UserType.parent,
                  child: Text('Parent'),
                ),
                DropdownMenuItem<UserType>(
                  value: UserType.child,
                  child: Text('Child'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _userType = value!;
                });
              },
            ),
            const SizedBox(height: 15),
            AuthFormField(
              controller: _nameController,
              hintText: 'Full Name',
              labelText: 'Full Name',
              prefixIcon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
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
            const SizedBox(height: 15),
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
            const SizedBox(height: 15),
            AuthFormField(
              controller: _confirmPasswordController,
              hintText: 'Confirm Password',
              labelText: 'Confirm Password',
              prefixIcon: Icons.lock_outline,
              obscureText: _obscureConfirmPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  );
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
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
                  text: 'Sign Up',
                  isLoading: state is AuthLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget.onSignUp?.call(
                        _userType,
                        _emailController.text,
                        _passwordController.text,
                        _nameController.text,
                      );
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 14),
            // Sign In Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.grey.shade600),
                ),
                TextButton(
                  onPressed: widget.onSignInTap,
                  style: Theme.of(context).textButtonTheme.style?.copyWith(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 0),
                    ),
                  ),
                  child: Text(
                    'Sign In',
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
