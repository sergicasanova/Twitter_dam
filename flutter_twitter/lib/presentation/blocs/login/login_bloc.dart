import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/domain/repositories/user_repository.dart';
import 'package:flutter_twitter/domain/usecases/login_usecase.dart';
import 'package:flutter_twitter/presentation/blocs/login/login_event.dart';
import 'package:flutter_twitter/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUser;
  final UserRepository authRepository;

  LoginBloc(this.loginUser, this.authRepository) : super(const LoginState()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await loginUser(event.username, event.password);
      result.fold(
          (error) => emit(
              state.copyWith(isLoading: false, errorMessage: error.toString())),
          (user) {
        emit(state.copyWith(isLoading: false, user: user));
      });
    });

    // on<LogoutButtonPressed>((event, emit) async {
    //   await authRepository.logout();
    //   emit(const LoginState());
    // });
  }
}
