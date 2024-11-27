import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_state.dart';

class UserSettingsDialog extends StatefulWidget {
  const UserSettingsDialog({super.key});

  @override
  State<UserSettingsDialog> createState() => _UserSettingsDialogState();
}

class _UserSettingsDialogState extends State<UserSettingsDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userBloc = BlocProvider.of<AuthBloc>(context);
    _nombreController.text = userBloc.state.user?.username ?? "";
    _avatarController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Text(
                  "Ajustes del Usuario",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nombreController,
                        decoration: const InputDecoration(
                          labelText: "Nombre de Usuario",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _avatarController,
                        decoration: const InputDecoration(
                          labelText: "Avatar: URL",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              UpdateUserInfoUseCaseEvent(
                                BlocProvider.of<AuthBloc>(context)
                                    .state
                                    .user!
                                    .id,
                                _avatarController.text,
                                _nombreController.text,
                              ),
                            );
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: const Text(
                        "Aceptar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
