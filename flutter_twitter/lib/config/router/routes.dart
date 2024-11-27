import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/domain/repositories/user_repository.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/tweet/tweet_bloc.dart';
import 'package:flutter_twitter/presentation/screens/login_screen.dart';
import 'package:flutter_twitter/presentation/screens/main_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_twitter/injection.dart' as inj;

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => BlocProvider(
        create: (context) => inj.sl<AuthBloc>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => BlocProvider(
        create: (context) => inj.sl<TweetBloc>(),
        child: const MainScreen(),
      ),
    ),
  ],
  redirect: (context, state) async {
    final isLoggedIn = await inj.sl<UserRepository>().isLoggedIn();
    return isLoggedIn.fold((_) => '/login', (loggedIn) {
      if (!loggedIn && !state.matchedLocation.contains("/login")) {
        return "/login";
      } else {
        return state.matchedLocation;
      }
    });
  },
);
