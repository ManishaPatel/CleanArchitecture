import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static double getMaxWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (isMobile(context)) {
      return width; // Full width on mobile
    } else if (isTablet(context)) {
      return 700; // Constrained width on tablet
    } else {
      return 800; // Constrained width on desktop
    }
  }

  static EdgeInsets getPadding(BuildContext context) {
    if (isMobile(context)) {
      return EdgeInsets.zero;
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 24);
    } else {
      return const EdgeInsets.symmetric(horizontal: 32);
    }
  }
}

/// Responsive wrapper that centers content and constrains width on larger screens
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsets? padding;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveMaxWidth = maxWidth ?? Responsive.getMaxWidth(context);
    final effectivePadding = padding ?? Responsive.getPadding(context);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: effectiveMaxWidth,
        ),
        child: Padding(
          padding: effectivePadding,
          child: child,
        ),
      ),
    );
  }
}

