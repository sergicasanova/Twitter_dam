import 'package:equatable/equatable.dart';
import 'package:flutter_twitter/domain/entities/user.dart';

class AuthState extends Equatable {
  final User? user;
  final User? userBrowser;
  final bool isLoading;
  final String errorMessage;

  const AuthState({
    required this.user,
    required this.userBrowser,
    required this.isLoading,
    required this.errorMessage,
  });

  factory AuthState.initial() {
    return const AuthState(
      user: null,
      userBrowser: null,
      isLoading: false,
      errorMessage: '',
    );
  }

  AuthState copyWith({
    User? user,
    User? userBrowser,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      userBrowser: userBrowser ?? this.userBrowser,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [user, userBrowser, isLoading, errorMessage];
}
