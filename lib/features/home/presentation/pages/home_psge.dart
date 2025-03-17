import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/routes.dart';
import '../../../Auth/bloc/auth_bloc.dart';
import '../../../Auth/data/repositories/auth_repository.dart';
import '../../../parent/child_management/bloc/child_bloc.dart';
import '../../../parent/child_management/data/repositories/child_repository.dart';
import '../widgets/home_body.dart';

class HomePsge extends StatelessWidget {
  const HomePsge({super.key});

  @override
  Widget build(BuildContext context) {
    final uaer =
        RepositoryProvider.of<AuthRepository>(context).getCurrentUser();
    return RepositoryProvider(
      create: (context) => ChildRepository(),
      child: BlocProvider<ChildBloc>(
        create:
            (context) => ChildBloc(
              childRepository: RepositoryProvider.of<ChildRepository>(context),
            )..add(LoadChildrenEvent(uaer!.uid)),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              actions: [
                IconButton(
                  onPressed: () async {
                    context.read<AuthBloc>().add(SignOutEvent());
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is UnAuthenticated) {
                  context.pushReplacementNamed(AppRoute.signin.name);
                }
                if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return HomeBody();
              },
            ),
          ),
        ),
      ),
    );
  }
}
