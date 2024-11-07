// theme.dart

import 'package:flutter/material.dart';

class Theme extends ThemeData {
  const Theme({super.key}) : super(
    scaffoldBackgroundColor: Color(0xFF10A5BB),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );
}