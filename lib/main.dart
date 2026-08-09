import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const SplitEaseApp());
}

class SplitEaseApp extends StatelessWidget {
  const SplitEaseApp({super.key});

  static const Color _seedColor = Color(0xFF00796B);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    );

    // Start from a full Material 3 theme, then override only what we need.
    // Replacing textTheme entirely causes TextStyle animation errors.
    final baseTheme = ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
    );

    return MaterialApp(
      title: 'SplitEase',
      debugShowCheckedModeBanner: false,
      theme: baseTheme.copyWith(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: baseTheme.appBarTheme.copyWith(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: const Color(0xFFF5F7FA),
          foregroundColor: colorScheme.onSurface,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        textTheme: baseTheme.textTheme.copyWith(
          headlineSmall: baseTheme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          titleMedium: baseTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: baseTheme.textTheme.bodyMedium?.copyWith(
            fontSize: 14,
          ),
          bodySmall: baseTheme.textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        cardTheme: baseTheme.cardTheme.copyWith(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        dividerTheme: baseTheme.dividerTheme.copyWith(
          color: Colors.grey.shade200,
          thickness: 1,
          space: 1,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: _seedColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            // Avoid TextStyle lerp errors on press / hot reload.
            animationDuration: Duration.zero,
          ),
        ),
        floatingActionButtonTheme: baseTheme.floatingActionButtonTheme.copyWith(
          backgroundColor: _seedColor,
          foregroundColor: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        bottomNavigationBarTheme: baseTheme.bottomNavigationBarTheme.copyWith(
          backgroundColor: Colors.white,
          selectedItemColor: _seedColor,
          unselectedItemColor: Colors.grey.shade500,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        snackBarTheme: baseTheme.snackBarTheme.copyWith(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
