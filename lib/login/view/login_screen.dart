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

// class _EmailInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginCubit, LoginState>(
//       buildWhen: (previous, current) => previous.email != current.email,
//       builder: (context, state) {
//         return TextField(
//           key: const Key('loginForm_emailInput_textField'),
//           onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
//           keyboardType: TextInputType.emailAddress,
//           decoration: InputDecoration(
//             labelText: 'email',
//             helperText: '',
//             //errorText: state.email.invalid ? 'invalid email' : null,
//           ),
//         );
//       },
//     );
//   }
// }

// class _PasswordInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginCubit, LoginState>(
//       buildWhen: (previous, current) => previous.password != current.password,
//       builder: (context, state) {
//         return TextField(
//           key: const Key('loginForm_passwordInput_textField'),
//           onChanged: (password) =>
//               context.read<LoginCubit>().passwordChanged(password),
//           obscureText: true,
//           decoration: InputDecoration(
//             labelText: 'password',
//             helperText: '',
//             //errorText: state.password.invalid ? 'invalid password' : null,
//           ),
//         );
//       },
//     );
//   }
// }
