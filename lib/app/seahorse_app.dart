import 'package:flutter/material.dart';
import 'package:seahorse/app_router/app_router.dart';
import 'package:seahorse/app_theme/app_theme.dart';

class SeahorseApp extends StatelessWidget {
  const SeahorseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
