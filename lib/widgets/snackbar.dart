import 'package:flutter/material.dart';

class AppSnackBar {
  static void info(context, text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void error(context, text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).colorScheme.error,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void success(context, text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green.shade800,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

// class AppSnackBar extends StatelessWidget {
//   const AppSnackBar({super.key, required this.message});

//   final String message;

//   @override
//   Widget build(BuildContext context) {
//     return SnackBar(
//       content: Text(message),
//     );
//   }
// }
