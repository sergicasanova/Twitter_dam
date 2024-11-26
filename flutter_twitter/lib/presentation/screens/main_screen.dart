import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_twitter/presentation/widgets/appbar.dart';
import 'package:flutter_twitter/presentation/widgets/drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state.user == null || state.isLoading) {
        context.read<AuthBloc>().add(GetUserCaseEvent());
        return const CircularProgressIndicator();
      } else if (state.errorMessage.isNotEmpty) {
        return Text(state.errorMessage);
      } else {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBarDefault(scaffoldKey: scaffoldKey),
          endDrawer: const MenuLateral(),
        );
      }
    });
  }
}
