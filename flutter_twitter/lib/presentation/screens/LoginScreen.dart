import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proyecto_final/presentation/blocs/login/login_bloc.dart';
import 'package:flutter_proyecto_final/presentation/blocs/login/login_event.dart';
import 'package:flutter_proyecto_final/presentation/blocs/login/login_state.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
