import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class BaseViewModel<T> extends ChangeNotifier {
  late T? view;
  bool loading = false;
  String? errorMessage;

  // ignore: avoid_positional_boolean_parameters
  void toggleLoadingOn(bool on, {bool isCallNotifier = true}) {
    loading = on;
    if (isCallNotifier) {
      notifyListeners();
    }
  }

  void setErrorMessage(String value) {
    errorMessage = value;
  }

  void attachView(T view) {
    this.view = view;
  }

  void detachView() {
    this.view = null;
  }

  static OverlayEntry overlayLoader() {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: Colors.black.withOpacity(0.8),
          child: CircularProgressIndicator(),
      ));
    });
    return loader;
  }

  static hideLoader(OverlayEntry loader) {
    Timer(const Duration(milliseconds: 500), () {
      try {
        loader.remove();
      } catch (e) {}
    });
  }
}
