import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'app/app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //firebase integration code
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}