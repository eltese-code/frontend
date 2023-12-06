import 'dart:ui';

import 'package:flutter/material.dart';

class AppLogic {
  Size _appSize = Size.zero;

  void handleAppSizeChanged(Size appSize) {
    _appSize = appSize;
  }
}
