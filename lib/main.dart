import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow/features/parent/child_management/bloc/child_bloc.dart';
import 'package:voca_grow/features/parent/child_management/data/repositories/child_repository.dart';
import 'core/router/router.dart';
import 'core/utils/app_bloc_observer.dart';
import 'core/utils/app_theme.dart';
import 'core/utils/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/Auth/bloc/auth_bloc.dart';
import 'features/Auth/data/repositories/auth_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => ChildRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create:
                (context) =>
                    AuthBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider(
            lazy: false,
            create:(context) =>ChildBloc(repository: context.read<ChildRepository>())..add(FetchChildren()),
          ),
        ],
        child: const VocaGrowApp(),
      ),
    ),
  );
}

class VocaGrowApp extends StatelessWidget {
  const VocaGrowApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Voca Grow App',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter(context.read<AuthBloc>()),
    );
  }
}
