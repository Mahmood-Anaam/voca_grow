import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:voca_grow/features/splash/presentation/splash_psge.dart';
import 'core/router/router.dart';
import 'core/router/routes.dart';
import 'core/utils/app_theme.dart';
import 'core/utils/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/Auth/bloc/auth_bloc.dart';
import 'features/parent/child_management/bloc/child_bloc.dart';
import 'features/parent/child_management/data/repositories/child_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const VocaGrowApp());
}

class VocaGrowApp extends StatelessWidget {
  const VocaGrowApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
        BlocProvider<ChildBloc>(
          create:
              (BuildContext context) =>
                  ChildBloc(ChildRepository())
                    ..add(LoadChildrenEvent("parentId")),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Voca Grow App',
        theme: AppTheme.lightTheme,
        routerConfig: router,
        
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
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
        return const SplashPsge();
      },
    );
  }
}
