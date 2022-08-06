import 'package:flutter/material.dart';

/// An abstraction around Material [Page] to enforce required
/// arguments within the app.
abstract class BasePage<T> extends Page<T> {
  /// Defines the [ValueKey] value for the given [Page].
  ///
  /// Should be unique to the current [BasePage] as it
  /// is used to check equality of pages within the stack when replacing
  /// routes with the same `keyValue`.
  final String keyValue;

  /// Defines the route name for the current [BasePage].
  final String routeName;

  /// Creates a [BasePage].
  ///
  /// This should be used over [Page] to ensure a `keyValue`
  /// and `routeName` value is provided.
  BasePage({
    required this.keyValue,
    required this.routeName,
    Object? arguments,
  }) : super(
          key: ValueKey(keyValue),
          name: routeName,
          arguments: arguments,
        );
}
