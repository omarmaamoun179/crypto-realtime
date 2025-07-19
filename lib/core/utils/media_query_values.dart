import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  double get topPadding => MediaQuery.paddingOf(this).top;
  double get bottom => MediaQuery.viewInsetsOf(this).bottom;
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;
}
