import 'package:flutter/material.dart';
import 'package:flutter_twitter/presentation/widgets/dialogs/logout_dialog.dart';

Future<void> mostrarLogOut(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return const LogOutUser();
      });
}
