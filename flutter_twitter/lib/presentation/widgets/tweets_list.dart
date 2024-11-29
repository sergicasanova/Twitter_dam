import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/tweet/tweet_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/tweet/tweet_event.dart';
import 'package:flutter_twitter/domain/entities/tweet.dart';
import 'package:flutter_twitter/presentation/screens/create_screen.dart';

class TweetsContainer extends StatelessWidget {
  final List<Tweet> tweets;

  const TweetsContainer({Key? key, required this.tweets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthBloc>();

    return ListView.builder(
      itemCount: tweets.length,
      itemBuilder: (context, index) {
        final tweet = tweets[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: tweet.userAvatar != null
                              ? NetworkImage(tweet.userAvatar!)
                              : null,
                          child: tweet.userAvatar == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          tweet.userId,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tweet.content,
                      style: const TextStyle(fontSize: 14),
                    ),
                    if (tweet.image != null) ...[
                      const SizedBox(height: 8),
                      Image.network(tweet.image!),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: tweet.likes.contains(currentUserId)
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            BlocProvider.of<TweetBloc>(context).add(
                              LikeTweetUseCaseEvent(
                                tweetId: tweet.id,
                                userId: currentUserId.state.user!.id,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${tweet.likes.length}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (tweet.userId == currentUserId.state.user!.id)
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateTweetScreen(tweet: tweet),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
