import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget logo;
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          child: logo,
        ),
        // const SizedBox(height: 10),
        Text(title, style: TextTheme.of(context).titleLarge),
        const SizedBox(height: 10),
        Text(subtitle, style: TextTheme.of(context).titleSmall),
      ],
    );
  }
}
