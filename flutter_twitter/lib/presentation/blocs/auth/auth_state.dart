import 'package:equatable/equatable.dart';
import 'package:flutter_twitter/domain/entities/user.dart';

class AuthState extends Equatable {
  final User? user;
  final User? userBrowser;
  final List<User> allUsers;
  final List<User> filteredUsers;
  final String filter;
  final bool isLoading;
  final String errorMessage;

  const AuthState({
    required this.user,
    required this.userBrowser,
    required this.allUsers,
    required this.filteredUsers,
    required this.filter,
    required this.isLoading,
    required this.errorMessage,
  });

  factory AuthState.initial() {
    return const AuthState(
      user: null,
      userBrowser: null,
      allUsers: [],
      filteredUsers: [],
      filter: '',
      isLoading: false,
      errorMessage: '',
    );
  }

  AuthState copyWith({
    User? user,
    User? userBrowser,
    List<User>? allUsers,
    List<User>? filteredUsers,
    String? filter,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      userBrowser: userBrowser ?? this.userBrowser,
      allUsers: allUsers ?? this.allUsers,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        user,
        userBrowser,
        allUsers,
        filteredUsers,
        filter,
        isLoading,
        errorMessage
      ];
}
