import 'package:dartz/dartz.dart';
import 'package:flutter_twitter/domain/repositories/user_repository.dart';

class LogoutUserCase {
  final UserRepository repository;

  LogoutUserCase(this.repository);

  Future<Either<String, void>> call() async {
    try {
      await repository.logout();
      return const Right(null);
    } catch (e) {
      return Left("Error al cerrar sesión: $e");
    }
  }
}
