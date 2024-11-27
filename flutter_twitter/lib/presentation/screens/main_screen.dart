import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/data/models/tweet_model.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_twitter/presentation/blocs/tweet/tweet_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/tweet/tweet_event.dart';
import 'package:flutter_twitter/presentation/blocs/tweet/tweet_state.dart';
import 'package:flutter_twitter/presentation/widgets/appbar.dart';
import 'package:flutter_twitter/presentation/widgets/drawer.dart';
import 'package:flutter_twitter/presentation/widgets/tweets_list.dart'; // Importamos el widget de los tweets
import 'package:flutter_twitter/domain/entities/tweet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TweetBloc>().add(GetTweetsUseCaseEvent());
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state.user == null || state.isLoading) {
        context.read<AuthBloc>().add(GetUserCaseEvent());
        return const CircularProgressIndicator();
      } else if (state.errorMessage.isNotEmpty) {
        return Text(state.errorMessage);
      } else {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBarDefault(scaffoldKey: scaffoldKey),
          endDrawer: const MenuLateral(),
          body: BlocBuilder<TweetBloc, TweetState>(
              builder: (context, tweetState) {
            if (tweetState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (tweetState.errorMessage.isNotEmpty) {
              return Center(child: Text('Error: ${tweetState.errorMessage}'));
            } else if (tweetState.tweets.isEmpty) {
              return const Center(child: Text('No hay tweets disponibles.'));
            } else {
              return TweetsContainer(tweets: tweetState.tweets);
            }
          }),
        );
      }
    });
  }
}
