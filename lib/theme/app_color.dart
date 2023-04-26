import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class AppColors {
  static final TonalPalette base = toTonalPalette(0xAA20426F);
  static final TonalPalette primary = toTonalPalette(0xAA20426F);
  static final TonalPalette secondary = toTonalPalette(0xAA7C869A);
  static final TonalPalette tertiary = toTonalPalette(0xAA977D9F);
  static final TonalPalette error = toTonalPalette(0xAAFE4C44);
  static final TonalPalette neutral = toTonalPalette(0xAA858589);
  static final TonalPalette neutralVariant = toTonalPalette(0xAA82868E);
  
  //base #20426F
  //primary #20426F
  //secondary #7C869A
  //tertiary #977D9F
  //error #FE4C44
  //neutral #858589
  //neutral variant #82868E
}

// convert color from hex int val
TonalPalette toTonalPalette(int value) {
  final color = Hct.fromInt(value);
  return TonalPalette.of(color.hue, color.chroma);
}
