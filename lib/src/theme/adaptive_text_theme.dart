import 'package:flutter/material.dart';

/// A cross-platform typography model mapping to both Material and Cupertino typography standards.
class AdaptiveTextTheme {
  /// Creates an [AdaptiveTextTheme].
  const AdaptiveTextTheme({
    this.headline = const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    this.title = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    this.body = const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    this.label = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    this.caption = const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
  });

  /// Large prominent headline style.
  final TextStyle headline;

  /// Section or screen title style.
  final TextStyle title;

  /// Default reading/body text style.
  final TextStyle body;

  /// Button and badge label style.
  final TextStyle label;

  /// Supporting annotation or caption style.
  final TextStyle caption;
}
