import 'package:equatable/equatable.dart';

abstract class TweetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTweetsUseCaseEvent extends TweetEvent {}

class CreateTweetUseCaseEvent extends TweetEvent {
  final String userId;
  final String content;
  final String? image;

  CreateTweetUseCaseEvent(this.userId, this.content, this.image);

  @override
  List<Object?> get props => [userId, content, image];
}

class DeleteTweetUseCaseEvent extends TweetEvent {
  final String tweetId;

  DeleteTweetUseCaseEvent(this.tweetId);

  @override
  List<Object?> get props => [tweetId];
}

class LikeTweetUseCaseEvent extends TweetEvent {
  final String tweetId;
  final String userId;

  LikeTweetUseCaseEvent(this.tweetId, this.userId);

  @override
  List<Object?> get props => [tweetId, userId];
}

class UpdateTweetUseCaseEvent extends TweetEvent {
  final String userId;
  final String? content;
  final String? image;

  UpdateTweetUseCaseEvent(this.userId, this.content, this.image);

  @override
  List<Object?> get props => [userId, content, image];
}

class GetFollowUsersTweetsUseCaseEvent extends TweetEvent {
  final String userId;

  GetFollowUsersTweetsUseCaseEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
