import 'package:dartz/dartz.dart';
import 'package:flutter_twitter/data/datasources/user_remote_datasource.dart';
import 'package:flutter_twitter/data/models/user_model.dart';
import 'package:flutter_twitter/domain/entities/user.dart';
import 'package:flutter_twitter/domain/repositories/user_repository.dart';
import 'package:flutter_twitter/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, User>> login(String username, String password) async {
    final prefs = sl<SharedPreferences>();
    try {
      final response = await remoteDataSource.login(username, password);
      final user = UserModel.fromJson(response);
      print(
          'Datos del usuario: id=${user.id}, username=${user.username}, avatar=${user.avatar}');
      prefs.setString('user_id', user.id);
      return Right(user);
    } catch (e) {
      return Left('Error al hacer login: $e');
    }
  }

  @override
  Future<Either<String, User>> getUserInfo(String userId) async {
    try {
      final response = await remoteDataSource.getUserInfo(userId);
      final user = UserModel.fromJson(response);
      return Right(user);
    } catch (e) {
      return Left('Error obteniendo información del usuario: $e');
    }
  }

  @override
  Future<Either<String, User>> updateUser(
      String userId, String? username, String? avatar) async {
    try {
      final response =
          await remoteDataSource.updateUser(userId, username, avatar);
      final user = UserModel.fromJson(response);
      return Right(user);
    } catch (e) {
      return Left('Error actualizando la información del usuario: $e');
    }
  }

  @override
  Future<Either<Exception, bool>> isLoggedIn() async {
    try {
      final prefs = sl<SharedPreferences>();
      final userId = prefs.getString('user_id');
      return Right(userId != null);
    } catch (e) {
      return Left(
          Exception("Error al verificar si el usuario está logueado: $e"));
    }
  }

  @override
  Future<Either<String, List<User>>> getAllUsers() async {
    try {
      final response = await remoteDataSource.getAllUsers();
      final List<User> users = response.entries.map((entry) {
        final Map<String, dynamic> userJson =
            entry.value as Map<String, dynamic>;
        return UserModel.fromJson(userJson);
      }).toList();
      return Right(users);
    } catch (e) {
      return Left('Error obteniendo información de los usuarios: $e');
    }
  }

  @override
  Future<void> logout() async {
    final prefs = sl<SharedPreferences>();
    await prefs.remove('user_id');
  }

  @override
  Future<Either<String, User>> getUser() async {
    try {
      final prefs = sl<SharedPreferences>();
      final userId = prefs.getString('user_id');
      final response = await remoteDataSource.getUserInfo(userId!);
      final user = UserModel.fromJson(response);

      return Right(user);
    } catch (e) {
      return Left('Error obteniendo información del usuario: $e');
    }
  }

  @override
  Future<Either<String, bool>> followUser(
      String userToFollow, String userId) async {
    try {
      final response = await remoteDataSource.followUser(userToFollow, userId);
      return Right(response);
    } catch (e) {
      return Left('Fallo al obtener los tweets: $e');
    }
  }
}
