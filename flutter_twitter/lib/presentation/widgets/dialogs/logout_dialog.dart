import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_state.dart';
import 'package:go_router/go_router.dart';

class LogOutUser extends StatelessWidget {
  const LogOutUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        AlertDialog(
          title: const Text("Logout del Usuario",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              )),
          content: const Text(
            '¿Desea cerrar sesión?',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
