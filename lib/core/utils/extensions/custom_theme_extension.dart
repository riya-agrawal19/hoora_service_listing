import 'package:flutter/material.dart';

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color primaryColor;
  final Color backgroundColor;
  final Color cardBackgroundColor;
  final Color textColor;
  final Color subTextColor;
  final Color outlineColor;

  TextStyle heading = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 32,
  );

  TextStyle bodyBold = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  TextStyle bodySemiBold = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  TextStyle bodyMediumBold = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  TextStyle bodyRegularBold = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );

  CustomThemeExtension({
    required this.primaryColor,
    required this.backgroundColor,
    required this.cardBackgroundColor,
    required this.textColor,
    required this.subTextColor,
    required this.outlineColor,
  });

  @override
  CustomThemeExtension copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? cardBackgroundColor,
    Color? textColor,
    Color? subTextColor,
    Color? successColor,
    Color? outlineColor,
  }) => CustomThemeExtension(
    primaryColor: primaryColor ?? this.primaryColor,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
    textColor: textColor ?? this.textColor,
    subTextColor: subTextColor ?? this.subTextColor,
    outlineColor: outlineColor ?? this.outlineColor,
  );

  @override
  CustomThemeExtension lerp(
    ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) return this;
    return CustomThemeExtension(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      cardBackgroundColor: Color.lerp(
        cardBackgroundColor,
        other.cardBackgroundColor,
        t,
      )!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      subTextColor: Color.lerp(subTextColor, other.subTextColor, t)!,
      outlineColor: Color.lerp(outlineColor, other.outlineColor, t)!,
    );
  }
}
