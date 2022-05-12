import 'package:flutter/material.dart';

class InheritedDataProvider extends InheritedWidget {
  final String data;
  InheritedDataProvider({
    required Widget child,
    required this.data,
    finalToken,
  }) : super(child: child);
  @override
  bool updateShouldNotify(InheritedDataProvider oldWidget) =>
      data != oldWidget.data;
  static InheritedDataProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedDataProvider>();
}
