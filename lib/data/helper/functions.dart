import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/utils/extensions/custom_theme_extension.dart';

OverlayEntry overlayLoader({String? message}) {
  return OverlayEntry(
    builder: (context) {
      final customTheme =
      Theme.of(context).extension<CustomThemeExtension>();

      return Material(
        color: Colors.black.withOpacity(0.65),
        child: Column(
          mainAxisSize: MainAxisSize.min,              // keep compact
          mainAxisAlignment: MainAxisAlignment.center, // center contents
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                color: customTheme?.primaryColor ?? Colors.white,
                strokeWidth: 5,
              ),
            ),
            if (message != null && message.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: customTheme?.backgroundColor ?? Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      );
    },
  );
}

hideLoader(OverlayEntry loader) {
  Timer(const Duration(milliseconds: 500), () {
    try {
      loader.remove();
    } catch (e) {}
  });
}
