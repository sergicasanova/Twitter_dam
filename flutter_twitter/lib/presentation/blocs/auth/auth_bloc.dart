import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/domain/entities/user.dart';
import 'package:flutter_twitter/domain/repositories/user_repository.dart';
import 'package:flutter_twitter/domain/usecases/login/follow_user_usecase.dart';
import 'package:flutter_twitter/domain/usecases/login/get_user_info_usecase.dart';
import 'package:flutter_twitter/domain/usecases/login/get_user_usecase.dart';
import 'package:flutter_twitter/domain/usecases/login/login_usecase.dart';
import 'package:flutter_twitter/domain/usecases/login/update_user_info_usecase.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_twitter/domain/usecases/login/logout_usecase.dart';
import 'package:flutter_twitter/domain/usecases/login/get_all_users_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final UserRepository userRepository;
  final GetUserInfoUseCase getUserInfoUseCase;
  final UpdateUserInfoUseCase updateUserInfoUseCase;
  final GetUserUseCase getUserUseCase;
  final LogoutUserCase logoutUserCase;
  final GetAllUsersUseCase getAllUsersUseCase;
  final FollowUserUseCase followUserUseCase;

  AuthBloc({
    required this.getUserInfoUseCase,
    required this.loginUseCase,
    required this.updateUserInfoUseCase,
    required this.userRepository,
    required this.getUserUseCase,
    required this.logoutUserCase,
    required this.getAllUsersUseCase,
    required this.followUserUseCase,
  }) : super(AuthState.initial()) {
    on<GetUserInfoUseCaseEvent>(_onGetUserInfoUseCaseEvent);
    on<UpdateUserInfoUseCaseEvent>(_onUpdateUserInfoUseCaseEvent);
    on<LoginUseCaseEvent>(_onLoginUseCaseEvent);
    on<GetUserCaseEvent>(_onGetUserCase);
    on<LogoutEvent>(_onLogoutEvent);
    on<GetAllUsersEvent>(_onGetAllUsersEvent);
    on<FilterUsersEvent>(_onFilterUsersEvent);
    on<FollowUserEvent>(_onFollowUserEvent);
  }

  Future<void> _onFollowUserEvent(
    FollowUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final result = await userRepository.followUser(
        event.userToFollowId, event.currentUserId);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, errorMessage: error)),
      (success) {
        final updatedFollowing = List<String>.from(state.user!.following)
          ..add(event.userToFollowId);

        final updatedUser = User(
          id: state.user!.id,
          username: state.user!.username,
          avatar: state.user!.avatar,
          following: updatedFollowing,
        );

        emit(state.copyWith(
          isLoading: false,
          user: updatedUser,
        ));
      },
    );
  }

  Future<void> _onGetAllUsersEvent(
    GetAllUsersEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final result = await userRepository.getAllUsers();

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, errorMessage: error)),
      (users) => emit(state.copyWith(
        isLoading: false,
        allUsers: users,
      )),
    );
  }

  void _onFilterUsersEvent(
    FilterUsersEvent event,
    Emitter<AuthState> emit,
  ) {
    final filteredUsers = state.allUsers.where((user) {
      return user.username.toLowerCase().contains(event.filter.toLowerCase());
    }).toList();

    emit(state.copyWith(
      filteredUsers: filteredUsers,
      filter: event.filter,
    ));
  }

  Future<void> _onLoginUseCaseEvent(
    LoginUseCaseEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await loginUseCase(event.username, event.password);
    result.fold(
      (error) => emit(
          state.copyWith(isLoading: false, errorMessage: error.toString())),
      (user) => emit(state.copyWith(isLoading: false, user: user)),
    );
  }

  Future<void> _onGetUserCase(
    GetUserCaseEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getUserUseCase();
    result.fold(
      (error) => emit(
          state.copyWith(isLoading: false, errorMessage: error.toString())),
      (user) => emit(state.copyWith(isLoading: false, user: user)),
    );
  }

  Future<void> _onUpdateUserInfoUseCaseEvent(
    UpdateUserInfoUseCaseEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result =
        await updateUserInfoUseCase(event.userId, event.username, event.avatar);

    result.fold(
      (error) => emit(
          state.copyWith(isLoading: false, errorMessage: error.toString())),
      (inventory) {
        emit(state.copyWith(
          isLoading: false,
        ));
      },
    );
  }

  Future<void> _onGetUserInfoUseCaseEvent(
    GetUserInfoUseCaseEvent event,
    Emitter<AuthState> emit,
  ) async {
    final userBrowser = await getUserInfoUseCase(event.userId);
    userBrowser.fold(
      (error) {
        emit(state.copyWith(user: null));
      },
      (user) {
        emit(state.copyWith(userBrowser: user));
      },
    );
  }

  Future<void> _onLogoutEvent(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      await userRepository.logout();
      emit(AuthState.initial());
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Error al cerrar sesión: $error",
      ));
    }
  }
}
