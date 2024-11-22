import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/domain/repositories/user_repository.dart';
import 'package:flutter_twitter/domain/usecases/get_user_info_usecase.dart';
import 'package:flutter_twitter/domain/usecases/get_user_usecase.dart';
import 'package:flutter_twitter/domain/usecases/login_usecase.dart';
import 'package:flutter_twitter/domain/usecases/update_user_info_usecase.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final UserRepository userRepository;
  final GetUserInfoUseCase getUserInfoUseCase;
  final UpdateUserInfoUseCase updateUserInfoUseCase;
  final GetUserUseCase getUserUseCase;

  AuthBloc({
    required this.getUserInfoUseCase,
    required this.loginUseCase,
    required this.updateUserInfoUseCase,
    required this.userRepository,
    required this.getUserUseCase,
  }) : super(AuthState.initial()) {
    on<GetUserInfoUseCaseEvent>(_onGetUserInfoUseCaseEvent);
    on<UpdateUserInfoUseCaseEvent>(_onUpdateUserInfoUseCaseEvent);
    on<LoginUseCaseEvent>(_onLoginUseCaseEvent);
    on<GetUserCaseEvent>(_onGetUserCase);
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
}
