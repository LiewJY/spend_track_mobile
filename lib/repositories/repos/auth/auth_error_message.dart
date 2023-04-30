import 'package:flutter/material.dart';
import 'package:track/l10n/l10n.dart';

String authErrorMessage(BuildContext context, String errorCode) {
  final l10n = context.l10n;
  switch (errorCode) {
    case 'user-disabled':
      return l10n.userDisabled;
    case 'user-not-found':
      return l10n.userNotFound;
    case 'wrong-password':
      return l10n.wrongPassword;
    default:
      return l10n.firebaseAuthDefault;
  }
}
