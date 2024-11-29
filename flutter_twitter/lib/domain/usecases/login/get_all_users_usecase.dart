import 'package:dartz/dartz.dart';
import 'package:flutter_twitter/domain/entities/user.dart';
import 'package:flutter_twitter/domain/repositories/user_repository.dart';

class GetAllUsersUseCase {
  final UserRepository repository;

  GetAllUsersUseCase(this.repository);

  Future<Either<String, List<User>>> call() {
    return repository.getAllUsers();
  }
}
