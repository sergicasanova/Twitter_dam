import 'package:equatable/equatable.dart';

abstract class TweetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTweetsUseCaseEvent extends TweetEvent {}

class CreateTweetUseCaseEvent extends TweetEvent {
  final String userId;
  final String avatar;
  final String content;
  final String? image;

  CreateTweetUseCaseEvent(
      {required this.userId,
      required this.avatar,
      required this.content,
      this.image});

  @override
  List<Object?> get props => [userId, avatar, content, image];
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

  LikeTweetUseCaseEvent({
    required this.tweetId,
    required this.userId,
  });

  @override
  List<Object?> get props => [tweetId, userId];
}

class UpdateTweetUseCaseEvent extends TweetEvent {
  final String tweetId;
  final String? content;
  final String? image;

  UpdateTweetUseCaseEvent({required this.tweetId, this.content, this.image});

  @override
  List<Object?> get props => [tweetId, content, image];
}

class GetFollowUsersTweetsUseCaseEvent extends TweetEvent {
  final String userId;

  GetFollowUsersTweetsUseCaseEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
