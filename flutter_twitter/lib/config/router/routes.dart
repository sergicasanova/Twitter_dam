import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/login/login_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_twitter/injection.dart' as inj;

final GoRoute appRouter = GoRoute(
    initialLocation: '/login',
    routes: [
      GoRoute(
          path: '/login',
          builder: (context, state) {
            return const LoginScreen();
          }),
    ],
    redirect: (context, state) async {
      final loginState = context.read<LoginBloc>().state;
      if (loginState.user == null) {
        return '/login';
      } else {
        return null;
      }
    });
