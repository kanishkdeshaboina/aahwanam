// responsive_utils.dart
import 'package:flutter/material.dart';

class ResponsiveUtils {
  // static const double _designWidth = 390; // Reference width (your emulator width)
  // static const double _designHeight = 844; // Reference height
  static const double _designWidth = 375; // iPhone 12 Pro width
  static const double _designHeight = 812; // iPhone 12 Pro height

  // Get responsive width based on screen width
  static double getResponsiveWidth(BuildContext context, double width) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (width / _designWidth) * screenWidth;
  }

  // Get responsive height based on screen height
  static double getResponsiveHeight(BuildContext context, double height) {
    final screenHeight = MediaQuery.of(context).size.height;
    return (height / _designHeight) * screenHeight;
  }

  // Get responsive font size
  static double getResponsiveFontSize(BuildContext context, double fontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / _designWidth;
    return fontSize * scaleFactor;

    // Limit scaling to reasonable bounds
    if (scaleFactor > 1.5) return fontSize * 1.5;
    if (scaleFactor < 0.8) return fontSize * 0.8;

    return fontSize * scaleFactor;
  }

  // Get responsive padding
  static EdgeInsets getResponsivePadding(
      BuildContext context, {
        double? all,
        double? horizontal,
        double? vertical,
        double? left,
        double? top,
        double? right,
        double? bottom,
      }) {
    return EdgeInsets.only(
      left: left ?? horizontal ?? all ?? 0,
      top: top ?? vertical ?? all ?? 0,
      right: right ?? horizontal ?? all ?? 0,
      bottom: bottom ?? vertical ?? all ?? 0,
    );
  }

  // Check if device is tablet
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide > 600;
  }

  // Check if device is small phone
  static bool isSmallPhone(BuildContext context) {
    return MediaQuery.of(context).size.width < 360;
  }
}