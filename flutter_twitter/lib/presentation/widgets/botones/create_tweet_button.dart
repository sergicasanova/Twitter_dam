import 'package:flutter/material.dart';
import 'package:flutter_twitter/presentation/screens/create_screen.dart';

class CreateTweetButton extends StatelessWidget {
  const CreateTweetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateTweetScreen(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
