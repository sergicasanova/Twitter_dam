import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter/domain/entities/tweet.dart';
import 'package:flutter_twitter/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/tweet/tweet_bloc.dart';
import 'package:flutter_twitter/presentation/blocs/tweet/tweet_event.dart';

class CreateTweetScreen extends StatefulWidget {
  final Tweet? tweet;

  const CreateTweetScreen({super.key, this.tweet});

  @override
  State<CreateTweetScreen> createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends State<CreateTweetScreen> {
  final _formKey = GlobalKey<FormState>();
  late String? _content;
  late String? _image;

  @override
  void initState() {
    super.initState();
    _content = widget.tweet?.content ?? '';
    _image = widget.tweet?.image ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>();
    final userId = authState.state.user!.id;
    final userAvatar = authState.state.user!.avatar;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tweet == null ? 'Crear Tweet' : 'Editar Tweet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _content,
                decoration: const InputDecoration(
                  labelText: 'Contenido',
                  hintText: '¿Qué estás pensando?',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el contenido del tweet';
                  }
                  return null;
                },
                onSaved: (value) => _content = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _image,
                decoration: const InputDecoration(
                  labelText: 'URL de Imagen (opcional)',
                  hintText: 'https://...',
                ),
                onSaved: (value) => _image = value,
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (widget.tweet == null) {
                        context.read<TweetBloc>().add(
                              CreateTweetUseCaseEvent(
                                userId: userId,
                                avatar: userAvatar,
                                content: _content!,
                                image:
                                    _image?.isNotEmpty == true ? _image : null,
                              ),
                            );
                      } else {
                        context.read<TweetBloc>().add(
                              UpdateTweetUseCaseEvent(
                                tweetId: widget.tweet!.id,
                                content: _content!,
                                image:
                                    _image?.isNotEmpty == true ? _image : null,
                              ),
                            );
                      }

                      Navigator.pop(context, true);
                    }
                  },
                  child: Text(widget.tweet == null
                      ? 'Publicar Tweet'
                      : 'Actualizar Tweet'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
