import 'package:go_router/go_router.dart';
import 'package:voca_grow/features/Auth/bloc/auth_bloc.dart';
import '../../features/Auth/data/models/models.dart';
import '../../features/Auth/presentation/pages/reset_password/reset_password_page.dart';
import '../../features/Auth/presentation/pages/signin/signin_page.dart';
import '../../features/Auth/presentation/pages/signup/signup_page.dart';
import '../../features/splash/presentation/splash_psge.dart';
import '../../features/parent/home/presentation/pages/home_page.dart'
    as parent_home;
import '../../features/child/home/presentation/pages/home_page.dart'
    as child_home;
import 'routes.dart';

GoRouter appRouter(AuthBloc bloc) => GoRouter(
  initialLocation: '/${AppRoute.splash.name}',
  refreshListenable: bloc,
  routes: [
    GoRoute(
      path: '/${AppRoute.splash.name}',
      name: AppRoute.splash.name,
      builder: (context, state) => const SplashPsge(),
    ),
    GoRoute(
      path: '/${AppRoute.signin.name}',
      name: AppRoute.signin.name,
      builder: (context, state) => const SigninPage(),
    ),
    GoRoute(
      path: '/${AppRoute.signup.name}',
      name: AppRoute.signup.name,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/${AppRoute.resetpassword.name}',
      name: AppRoute.resetpassword.name,
      builder: (context, state) => const ResetPasswordPage(),
    ),
    GoRoute(
      path: '/${AppRoute.parenthome.name}',
      name: AppRoute.parenthome.name,
      builder: (context, state) => const parent_home.HomePage(),
    ),
    GoRoute(
      path: '/${AppRoute.childhome.name}',
      name: AppRoute.childhome.name,
      builder: (context, state) => const child_home.HomePage(),
    ),
  ],

  redirect: (context, state) {
    final authState = bloc.state;
    final restrictedPaths = {
      "/${AppRoute.signin.name}",
      "/${AppRoute.signup.name}",
      "/${AppRoute.resetpassword.name}",
    };

    if (authState is AuthInitial &&
        state.fullPath != "/${AppRoute.signin.name}" &&
        state.fullPath != "/${AppRoute.signup.name}") {
      return '/${AppRoute.splash.name}';
    }

    if (authState is Unauthenticated &&
        !restrictedPaths.contains(state.fullPath)) {
      return '/${AppRoute.signin.name}';
    }

    if (authState is Authenticated &&
        (state.fullPath == "/${AppRoute.signin.name}" ||
            state.fullPath == "/${AppRoute.signup.name}")) {
      return authState.user.userType == UserType.parent
          ? '/${AppRoute.parenthome.name}'
          : '/${AppRoute.childhome.name}';
    }

    return null;
  },
);
