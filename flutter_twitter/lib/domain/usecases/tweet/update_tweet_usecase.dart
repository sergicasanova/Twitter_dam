import 'package:dartz/dartz.dart';
import 'package:flutter_twitter/domain/repositories/tweet_repository.dart';

class UpdateTweetUseCase {
  final TweetRepository repository;

  UpdateTweetUseCase(this.repository);

  Future<Either<String, void>> call(
      String userId, String? content, String? image) {
    return repository.updateTweet(userId, content, image);
  }
}
