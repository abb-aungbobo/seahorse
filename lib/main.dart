import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seahorse/app/seahorse_app.dart';
import 'package:seahorse/locator/locator.dart';

void main() {
  setupLocator();
  runApp(
    const ProviderScope(
      child: SeahorseApp(),
    ),
  );
}
