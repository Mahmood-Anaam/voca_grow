import 'package:go_router/go_router.dart';
import 'package:voca_grow/features/Auth/bloc/auth_bloc.dart';
import 'package:voca_grow/features/parent/child_management/data/models/child_model.dart';
import 'package:voca_grow/features/parent/child_management/presentation/pages/child_info_page.dart';
import 'package:voca_grow/features/parent/child_management/presentation/pages/manage_children_page.dart';
import '../../features/Auth/data/models/user_model.dart';
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
  initialLocation: '/splash',
  refreshListenable: bloc,
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
      path: '/parenthome',
      name: AppRoute.parenthome.name,
      builder: (context, state) => const parent_home.HomePage(),
    ),

    GoRoute(
      path: '/managechildren',
      name: AppRoute.managechildren.name,
      builder: (context, state) => const ManageChildrenPage(),
    ),

    GoRoute(
      path: '/childinfo',
      name: AppRoute.childinfo.name,
      builder:
          (context, state) => ChildInfoPage(
            existingChild:
                state.extra != null ? state.extra as ChildModel : null,
          ),
    ),

    GoRoute(
      path: '/childhome',
      name: AppRoute.childhome.name,
      builder: (context, state) => const child_home.HomePage(),
    ),
  ],

  redirect: (context, state) {
    final authState = bloc.state;
    final restrictedPaths = {"/signin", "/signup", "/resetpassword"};

    if (authState is AuthInitial &&
        state.fullPath != "/signin" &&
        state.fullPath != "/signup") {
      return '/splash';
    }

    if (authState is Unauthenticated &&
        !restrictedPaths.contains(state.fullPath)) {
      return '/signin';
    }

    if (authState is Authenticated &&
        (state.fullPath == "/signin" || state.fullPath == "/signup")) {
      return authState.user.userType == UserType.parent
          ? '/parenthome'
          : '/childhome';
    }

    return null;
  },
);
