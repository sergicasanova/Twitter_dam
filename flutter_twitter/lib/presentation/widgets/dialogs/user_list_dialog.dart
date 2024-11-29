import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_twitter/domain/entities/user.dart';

class UserListDialog extends StatelessWidget {
  const UserListDialog({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(GetAllUsersEvent());

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state.errorMessage.isNotEmpty) {
            return SizedBox(
              height: 200,
              child: Center(
                child: Text('Error: ${state.errorMessage}'),
              ),
            );
          } else if (state.allUsers.isEmpty) {
            return const SizedBox(
              height: 200,
              child: Center(
                child: Text('No hay usuarios disponibles.'),
              ),
            );
          } else {
            final users = state.filteredUsers.isEmpty
                ? state.allUsers
                : state.filteredUsers;

            return SizedBox(
              height: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Buscar usuarios',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (query) {
                        context.read<AuthBloc>().add(FilterUsersEvent(query));
                      },
                    ),
                  ),
                  // Lista de usuarios
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        final isFollowing =
                            state.user?.following.contains(user.id) ?? false;

                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: user.avatar.isNotEmpty
                                  ? NetworkImage(user.avatar)
                                  : null,
                              child: user.avatar.isEmpty
                                  ? const Icon(Icons.person)
                                  : null,
                            ),
                            title: Text(user.username),
                            trailing: IconButton(
                              icon: Icon(
                                isFollowing
                                    ? Icons.check_circle
                                    : Icons.person_add,
                                color: isFollowing ? Colors.green : Colors.grey,
                              ),
                              onPressed: () {
                                if (!isFollowing) {
                                  context.read<AuthBloc>().add(
                                        FollowUserEvent(
                                          userToFollowId: user.id,
                                          currentUserId: state.user!.id,
                                        ),
                                      );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Botón de cierre
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cerrar'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
