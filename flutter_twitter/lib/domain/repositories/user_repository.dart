import 'package:dartz/dartz.dart';
import 'package:flutter_twitter/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<String, User>> login(String username, String password);

  Future<Either<String, User>> getUserInfo(String userId);

  Future<Either<String, User>> updateUser(
      String userId, String? username, String? avatar);

  Future<Either<Exception, bool>> isLoggedIn();

  Future<Either<String, List<User>>> getAllUsers();

  Future<void> logout();

  Future<Either<String, User>> getUser();

  Future<Either<String, bool>> followUser(String userToFollow, String userId);
}
