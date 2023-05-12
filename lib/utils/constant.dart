import 'package:flutter/material.dart';

class Constant {
  static const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);
  static const sizedBoxSpace = SizedBox(height: 24);
  static ButtonStyle fullWidthButton =
      ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40));
  //old
  // static const cardPadding = SizedBox(width: 16, height: 16);
  static const cardPadding = EdgeInsets.all(16);
    static const modalPadding =  EdgeInsets.symmetric(horizontal: 20.0, vertical: 32);

}
