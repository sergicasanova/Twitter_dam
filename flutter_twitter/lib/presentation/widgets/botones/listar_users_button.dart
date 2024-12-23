import 'package:flutter/material.dart';
import 'package:flutter_twitter/presentation/widgets/dialogs/user_list_dialog.dart';

class ViewUsersButton extends StatelessWidget {
  const ViewUsersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "viewUsers",
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const UserListDialog(),
        );
      },
      tooltip: 'Ver Usuarios',
      child: const Icon(Icons.people),
    );
  }
}
