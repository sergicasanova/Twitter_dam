import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserInfoUseCaseEvent extends AuthEvent {
  final String userId;

  GetUserInfoUseCaseEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UpdateUserInfoUseCaseEvent extends AuthEvent {
  final String userId;
  final String? username;
  final String? avatar;

  UpdateUserInfoUseCaseEvent(this.userId, this.avatar, this.username);

  @override
  List<Object?> get props => [userId, username, avatar];
}

class LoginUseCaseEvent extends AuthEvent {
  final String username;
  final String password;

  LoginUseCaseEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class GetUserCaseEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class GetAllUsersEvent extends AuthEvent {}

class FilterUsersEvent extends AuthEvent {
  final String filter;

  FilterUsersEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

class FollowUserEvent extends AuthEvent {
  final String userToFollowId;
  final String currentUserId;

  FollowUserEvent({
    required this.userToFollowId,
    required this.currentUserId,
  });

  @override
  List<Object?> get props => [userToFollowId, currentUserId];
}
