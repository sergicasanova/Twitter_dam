import 'package:equatable/equatable.dart';
import 'package:flutter_twitter/domain/entities/tweet.dart';

class TweetState extends Equatable {
  final List<Tweet> tweets;
  final bool isLoading;
  final String errorMessage;

  const TweetState({
    required this.tweets,
    required this.isLoading,
    required this.errorMessage,
  });

  factory TweetState.initial() {
    return const TweetState(
      tweets: [],
      isLoading: false,
      errorMessage: '',
    );
  }

  TweetState copyWith({
    List<Tweet>? tweets,
    bool? isLoading,
    String? errorMessage,
    String? filter,
  }) {
    return TweetState(
      tweets: tweets ?? this.tweets,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [tweets, isLoading, errorMessage];
}
