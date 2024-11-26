import 'package:dartz/dartz.dart';
import 'package:flutter_twitter/domain/entities/tweet.dart';
import 'package:flutter_twitter/domain/repositories/tweet_repository.dart';

class GetTweetsUseCase {
  final TweetRepository repository;

  GetTweetsUseCase(this.repository);

  Future<Either<String, List<Tweet>>> call() {
    return repository.getTweets();
  }
}
