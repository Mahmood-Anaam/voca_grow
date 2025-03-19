import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voca_grow/core/router/routes.dart';
import '../../../../../core/utils/assets.dart';
import 'feature_card.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final featureCards = [
      FeatureCard(
        icon: Icons.child_care,
        title: 'Manage Children',
        description: 'Add and manage child profiles',
        onTap: () {
          context.pushNamed(AppRoute.managechildren.name);
        },
      ),

      FeatureCard(
        icon: Icons.assessment,
        title: 'Track Progress',
        description: 'Monitor speech development',
        onTap: () {},
      ),
      FeatureCard(
        icon: Icons.settings,
        title: 'Account Settings',
        description: 'Manage your account',
        onTap: () {},
      ),
      FeatureCard(
        icon: Icons.help_outline,
        title: 'Support',
        description: 'Get help and resources',
        onTap: () {},
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the number of columns based on screen width
        int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        double childAspectRatio = constraints.maxWidth > 600 ? 1.2 : 0.8;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  child: Center(
                    child: Image.asset(
                      Assets.imagesHappyMic,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                // Welcome Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, Parent!',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                         
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Manage and track your child\'s speech development journey',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Features Grid
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: childAspectRatio,
                  ),

                  itemCount: featureCards.length,
                  itemBuilder: (context, index) {
                    return featureCards[index];
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
