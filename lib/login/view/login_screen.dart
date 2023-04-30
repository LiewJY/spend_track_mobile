import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/login/cubit/login_cubit.dart';
import 'package:track/login/login.dart';
import 'package:track/repositories/repos/auth_repository.dart';
import 'package:track/sign_up/sign_up.dart';
import 'package:track/widgets/widgets.dart';
import '../../uitls/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  //for routing
  static Page<void> page() => const MaterialPage<void>(child: LoginScreen());

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //for form
  final loginForm = GlobalKey<FormState>();

  //text field controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Constant.paddingHorizontal,
          child: BlocProvider(
            create: (context) => LoginCubit(context.read<AuthRepository>()),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}