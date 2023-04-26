import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:track/blocs/auth/auth_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/presentation/home_screen.dart';
import 'package:track/presentation/login_screen.dart';
import 'package:track/repository/auth_repository.dart';
import 'package:track/theme/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  //firebase integration code
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  bool useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.system;

  //todo
  //theme switching
  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return SchedulerBinding.instance.window.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;

    // //firestore demo
    // db.collection("users").get().then((event) {
    //   for (var doc in event.docs) {
    //     print("${doc.id} => ${doc.data()}");
    //   }
    // });

    // //firebase auth demo
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //   } else {
    //     print('User is signed in!');
    //   }
    // });

    return RepositoryProvider(
      //access auth repo
      create: (context) => AuthRepository(),
      child: BlocProvider(
        //access auth bloc
        create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: MaterialApp(
          //todo uncomment when complete
          //debugShowCheckedModeBanner: false,
          title: 'track',
          //todo change to changeble --> themeMode
          themeMode: ThemeMode.light,
          theme: AppTheme.lightThemeData,
          darkTheme: AppTheme.darkThemeData,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              //authenticated & success
              if (state is Authenticated) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              }
              //error in authentication
              if (state is AuthError) {
                //todo error snack bar
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return const Login();
                }
                return const Login();
              },
            ),
          ),
        ),
      ),
    );
  }
}
