import 'package:go_router/go_router.dart';
import '../../features/Auth/presentation/pages/reset_password/reset_password_page.dart';
import '../../features/Auth/presentation/pages/signin/signin_page.dart';
import '../../features/Auth/presentation/pages/signup/signup_page.dart';
import '../../features/home/presentation/pages/home_psge.dart';
import '../../features/splash/presentation/splash_psge.dart';
import 'routes.dart';

final router = GoRouter(
  initialLocation: '/signin',
  routes: [
    GoRoute(
      path: '/splash',
      name: AppRoute.splash.name,
      builder: (context, state) => const SplashPsge(),
    ),

    GoRoute(
      path: '/signin',
      name: AppRoute.signin.name,
      builder: (context, state) => const SigninPage(),
    ),
    GoRoute(
      path: '/signup',
      name: AppRoute.signup.name,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/resetpassword',
      name: AppRoute.resetpassword.name,
      builder: (context, state) => const ResetPasswordPage(),
    ),

    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomePsge(),
    ),
  ],
);
