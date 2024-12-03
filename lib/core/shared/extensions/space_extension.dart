import 'package:flutter/material.dart';

extension SpaceWidthExtension on int {
  Widget get w => SizedBox(width: toDouble());
}

extension SpaceHeightExtension on int {
  Widget get h => SizedBox(height: toDouble());
}
