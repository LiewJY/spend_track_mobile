import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:track_theme/track_theme.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.text,
  });

  final String color;
  final onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    getContainerColor() {
      switch (color) {
        case 'primary':
          return Theme.of(context).colorScheme.primaryContainer;
        case 'secondary':
          return Theme.of(context).colorScheme.secondaryContainer;
        default:
          return Theme.of(context).colorScheme.primaryContainer;
      }
    }

    getTextColor() {
      switch (color) {
        case 'primary':
          return Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.merge(
                  TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
          );
        case 'secondary':
          return Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.merge(
                  TextStyle(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
          );
        default:
          return Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.merge(
                  TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
          );
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: getContainerColor(),
        child: Padding(
          padding: AppStyle.cardPadding,
          child: getTextColor(),
        ),
      ),
    );
  }
}
