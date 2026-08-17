import 'package:flutter/material.dart';

/// Breakpoints and helper functions for responsive layout design.
///
/// Breakpoints:
/// - Mobile Portrait: width < 600, portrait orientation
/// - Mobile Landscape: landscape orientation with height < 600 or width < 900
/// - Tablet: 600 <= width < 900 in portrait or standard tablet dimensions
/// - Desktop: width >= 900
class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.mobile,
    this.mobileLandscape,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? mobileLandscape;
  final Widget? tablet;
  final Widget? desktop;

  static const double mobileMaxBreakPoint = 600;
  static const double tabletMaxBreakPoint = 900;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMaxBreakPoint &&
      MediaQuery.of(context).orientation == Orientation.portrait;

  static bool isMobileLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape &&
      MediaQuery.of(context).size.height < 600;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return (width >= mobileMaxBreakPoint && width < tabletMaxBreakPoint) ||
        (isPortrait && width >= mobileMaxBreakPoint && width < tabletMaxBreakPoint);
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMaxBreakPoint &&
      MediaQuery.of(context).size.height >= 600;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscapeMode =
            MediaQuery.of(context).orientation == Orientation.landscape;

        // Desktop layout when width >= 900 and height >= 500
        if (constraints.maxWidth >= tabletMaxBreakPoint &&
            constraints.maxHeight >= 500) {
          return desktop ?? tablet ?? mobile;
        }

        // Mobile / Small screen Landscape mode (e.g. phone turned sideways)
        if (isLandscapeMode &&
            mobileLandscape != null &&
            constraints.maxHeight < 600) {
          return mobileLandscape!;
        }

        // Tablet layout when width >= 600
        if (constraints.maxWidth >= mobileMaxBreakPoint) {
          return tablet ?? mobile;
        }

        // Mobile Portrait fallback
        return mobile;
      },
    );
  }
}
