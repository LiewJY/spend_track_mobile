import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:track_theme/track_theme.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.text,
    this.icon,
  });

  final String color;
  final onTap;
  final String text;
  final icon;

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

    getContent() {
      switch (color) {
        case 'primary':
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                this.icon,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.merge(
                      TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
              ),
            ],
          );
        case 'secondary':
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                this.icon,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.merge(
                      TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
              ),
            ],
          );
        default:
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                this.icon,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.merge(
                      TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
              ),
            ],
          );
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: getContainerColor(),
        child: Padding(
          padding: AppStyle.cardPadding,
          child: getContent(),
        ),
      ),
    );
  }
}
