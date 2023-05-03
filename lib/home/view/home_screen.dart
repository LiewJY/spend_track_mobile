import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/uitls/constant.dart';
import 'package:track/home/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  //for routing
  static Page<void> page() => const MaterialPage<void>(child: HomeScreen());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Constant.paddingHorizontal,
          child: HomeScreenContent(),
        ),
      ),
    );
  }
}
