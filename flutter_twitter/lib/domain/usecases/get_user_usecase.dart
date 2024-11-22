import 'package:dartz/dartz.dart';
import 'package:flutter_twitter/domain/entities/user.dart';
import 'package:flutter_twitter/domain/repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository repository;

  GetUserUseCase(this.repository);

  Future<Either<String, User>> call() {
    return repository.getUser();
  }
}
