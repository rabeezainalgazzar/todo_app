import 'package:go_router/go_router.dart';
import 'package:todolist/core/navigation/routes.dart';
import 'package:todolist/feautures/Onboarding/widget/onboarding_view.dart';
import 'package:todolist/feautures/auth/login_view.dart';
import 'package:todolist/feautures/auth/signup_view.dart';
import 'package:todolist/feautures/home/home_view.dart';
import 'package:todolist/feautures/splash/splash_view.dart';
import 'package:todolist/feautures/theme/theme_view.dart';
import 'package:todolist/feautures/welcom/welcome_view.dart';

class AppRouter {
  static GoRouter appRouter = GoRouter(
    initialLocation: Routes.kSplashView,
    routes: routes,
  );

  static List<GoRoute> routes = [
    GoRoute(
      path: Routes.kSplashView,
      name: Routes.kSplashView,
      builder: (context, state) => SplashView(),
    ),
    GoRoute(
      path: Routes.kOnboardingView,
      name: Routes.kOnboardingView,
      builder: (context, state) => const OnboardingView(),
    ),
    GoRoute(
      path: Routes.kWelcomeView,
      name: Routes.kWelcomeView,
      builder: (context, state) => const WelcomeView(),
    ),
    GoRoute(
      path: Routes.kLoginView,
      name: Routes.kLoginView,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: Routes.kSignupView,
      name: Routes.kSignupView,
      builder: (context, state) => const SignupView(),
    ),
    GoRoute(
      path: Routes.kThemeView,
      name: Routes.kThemeView,
      builder: (context, state) => const ThemeView(),
    ),
    GoRoute(
      path: Routes.kHomeView,
      name: Routes.kHomeView,
      builder: (context, state) => const HomeView(),
    ),
  ];
}
