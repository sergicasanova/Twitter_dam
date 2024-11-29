import 'package:dartz/dartz.dart';
import 'package:flutter_twitter/domain/repositories/tweet_repository.dart';

class CreateTweetUseCase {
  final TweetRepository repository;

  CreateTweetUseCase(this.repository);

  Future<Either<String, void>> call(
      String userId, String avatar, String content, String? image) {
    return repository.createTweet(userId, avatar, content, image);
  }
}
