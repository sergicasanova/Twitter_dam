import 'package:dartz/dartz.dart';
import 'package:flutter_twitter/domain/repositories/tweet_repository.dart';

class DeleteTweetUseCase {
  final TweetRepository repository;

  DeleteTweetUseCase(this.repository);

  Future<Either<String, void>> call(String tweetId) {
    return repository.deleteTweet(tweetId);
  }
}
