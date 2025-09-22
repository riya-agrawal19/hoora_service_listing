import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/extensions/custom_theme_extension.dart';

final _themeProvider = ChangeNotifierProvider((ref) => ThemeProvider());

class ThemeProvider extends ChangeNotifier {
  static ChangeNotifierProvider<ThemeProvider> get provider => _themeProvider;

  ThemeData get themeData {
    return lightTheme;
  }

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Montserrat',
    extensions: <ThemeExtension<dynamic>>[
      CustomThemeExtension(
        backgroundColor: const Color(0xFFF3F4F6),
        cardBackgroundColor: const Color(0xFFFFFFFF),
        primaryColor: const Color(0xFFFFCC00),
        textColor: const Color(0xFF000000),
        subTextColor: const Color(0xFF333333),
        outlineColor: const Color(0xFFE5E5E5),
      ),
    ],
  );
}
