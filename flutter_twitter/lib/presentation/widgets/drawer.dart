import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_bloc.dart';
// import 'package:flutter_twitter/presentation/functions/show_dialogs_functions.dart';

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
                    // await mostrarDialogoUsuario(context);
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
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
