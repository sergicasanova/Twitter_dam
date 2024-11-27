import 'package:flutter/material.dart';
import 'package:flutter_twitter/presentation/widgets/dialogs/logout_dialog.dart';
import 'package:flutter_twitter/presentation/widgets/dialogs/user_settings_dialog.dart';

Future<String?> mostrarLogOut(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return const LogOutUser();
    },
  );
}

Future<void> mostrarSettingsUsuario(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return const UserSettingsDialog();
      });
}
