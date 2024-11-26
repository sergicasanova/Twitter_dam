import 'package:dartz/dartz.dart';
import 'package:flutter_twitter/domain/repositories/user_repository.dart';

class UpdateUserInfoUseCase {
  final UserRepository repository;

  UpdateUserInfoUseCase(this.repository);

  Future<Either<String, void>> call(
      String userId, String? username, String? avatar) {
    return repository.updateUser(userId, username, avatar);
  }
}
