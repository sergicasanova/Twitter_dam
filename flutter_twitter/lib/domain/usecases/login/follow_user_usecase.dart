import 'package:dartz/dartz.dart';
import 'package:flutter_twitter/domain/repositories/user_repository.dart';

class FollowUserUseCase {
  final UserRepository repository;

  FollowUserUseCase(this.repository);

  Future<Either<String, bool>> call(String userToFollow, String userId) {
    return repository.followUser(userToFollow, userId);
  }
}
