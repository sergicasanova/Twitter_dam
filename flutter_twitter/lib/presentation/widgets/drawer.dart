import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_twitter/presentation/funtion/show_dialog.dart';
import 'package:go_router/go_router.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<AuthBloc>(context);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Material(
                  color: Colors.lightBlue,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top, bottom: 24),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 52,
                            backgroundImage:
                                NetworkImage(userBloc.state.user!.avatar),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            userBloc.state.user!.username,
                            style: const TextStyle(
                                fontSize: 28, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.app_settings_alt),
                  title: const Text('Ajustes de Usuario'),
                  onTap: () async {
                    await mostrarSettingsUsuario(context);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(bottom: 16),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cerrar Sesión',
                  style: TextStyle(color: Colors.black),
                ),
                Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
              ],
            ),
            onTap: () async {
              final resultado = await mostrarLogOut(context);
              if (!context.mounted) return;
              if (resultado == 'Aceptar') {
                context.read<AuthBloc>().add(LogoutEvent());
                if (!context.mounted) return;
                context.go('/login');
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
