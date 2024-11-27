import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/data/models/tweet_model.dart';
import 'package:flutter_twitter/presentation/blocs/tweet/tweet_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/tweet/tweet_event.dart';
import 'package:flutter_twitter/domain/entities/tweet.dart';

class TweetsContainer extends StatelessWidget {
  final List<Tweet> tweets;

  const TweetsContainer({Key? key, required this.tweets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tweets.length,
      itemBuilder: (context, index) {
        final tweet = tweets[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Padding(
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
                // Contenido del tweet
                Text(
                  tweet.content,
                  style: const TextStyle(fontSize: 14),
                ),
                if (tweet.image != null) ...[
                  const SizedBox(height: 8),
                  Image.network(tweet.image!),
                ],
                const SizedBox(height: 8),
                // Botón de "like"
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: tweet.likes.contains("exampleUserId")
                            ? Colors.red
                            : Colors.grey,
                      ),
                      onPressed: () {
                        // BlocProvider.of<TweetBloc>(context).add(
                        //   LikeTweetUseCaseEvent(
                        //     tweetId: tweet.id,
                        //     userId:
                        //         "exampleUserId",
                        //   ),
                        // );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
