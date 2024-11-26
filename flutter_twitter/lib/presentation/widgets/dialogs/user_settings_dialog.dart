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
    final userBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
    _nombreController.text = userBloc.state.user!.username;
    _avatarController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog();
  }
}
