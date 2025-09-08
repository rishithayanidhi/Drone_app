import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary gradient colors
  static const Color primaryTeal = Color(0xFF4ECDC4);
  static const Color primaryBlue = Color(0xFF45B7D1);
  static const Color primaryCyan = Color(0xFF96CEB4);

  // Emergency colors
  static const Color emergencyRed = Color(0xFFFF6B6B);
  static const Color emergencyOrange = Color(0xFFEE5A24);
  static const Color emergencyDark = Color(0xFFEA2027);

  // Background colors
  static const Color backgroundDark = Color(0xFF0A0E1A);
  static const Color backgroundMid = Color(0xFF1A1F2E);
  static const Color backgroundLight = Color(0xFF2C3E50);
  static const Color backgroundCard = Color(0xFF34495E);

  // Accent colors
  static const Color accentGold = Color(0xFFFFD700);
  static const Color accentWhite = Colors.white;
  static const Color accentGrey = Colors.grey;

  // Status colors
  static const Color statusOnline = Color(0xFF4ECDC4);
  static const Color statusOffline = Colors.red;
  static const Color statusWarning = Colors.orange;
}

class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primaryTeal,
      AppColors.primaryBlue,
      AppColors.primaryCyan,
    ],
  );

  static const LinearGradient emergencyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.emergencyRed,
      AppColors.emergencyOrange,
      AppColors.emergencyDark,
    ],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.backgroundDark,
      AppColors.backgroundMid,
      AppColors.backgroundLight,
      AppColors.backgroundCard,
    ],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.backgroundDark,
      AppColors.backgroundMid,
      AppColors.backgroundLight,
    ],
  );

  static LinearGradient logoGradient = LinearGradient(
    colors: [
      AppColors.primaryTeal,
      AppColors.primaryBlue,
      AppColors.accentGold,
    ],
  );
}

class AppTextStyles {
  // Orbitron styles (for tech/futuristic feel)
  static TextStyle logoLarge = GoogleFonts.orbitron(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: AppColors.accentWhite,
  );

  static TextStyle logoMedium = GoogleFonts.orbitron(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.accentWhite,
  );

  static TextStyle headingLarge = GoogleFonts.orbitron(
    fontSize: 22,
    fontWeight: FontWeight.w900,
    color: AppColors.accentWhite,
    letterSpacing: 2,
  );

  static TextStyle headingMedium = GoogleFonts.orbitron(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.accentWhite,
    letterSpacing: 1.5,
  );

  static TextStyle buttonText = GoogleFonts.orbitron(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.accentWhite,
  );

  // Exo2 styles (for body text and subtitles)
  static TextStyle subtitle = GoogleFonts.exo2(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryTeal,
    letterSpacing: 2,
  );

  static TextStyle bodyText = GoogleFonts.exo2(
    fontSize: 12,
    color: Colors.grey[400],
  );

  static TextStyle statusText = GoogleFonts.exo2(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static TextStyle warningText = GoogleFonts.orbitron(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.statusWarning,
  );

  static TextStyle warningTextSmall = GoogleFonts.orbitron(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.statusWarning,
  );
}

class AppShadows {
  static List<BoxShadow> primaryShadow = [
    BoxShadow(
      color: AppColors.primaryTeal.withValues(alpha: 0.3),
      blurRadius: 20,
      spreadRadius: 5,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> emergencyShadow = [
    BoxShadow(
      color: AppColors.emergencyRed.withValues(alpha: 0.4),
      blurRadius: 20,
      spreadRadius: 5,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> logoShadow = [
    BoxShadow(
      color: AppColors.primaryTeal.withValues(alpha: 0.3),
      blurRadius: 10,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      blurRadius: 15,
      spreadRadius: 2,
      offset: const Offset(0, 5),
    ),
  ];
}

class AppAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 500);
  static const Duration slow = Duration(milliseconds: 800);
  static const Duration verySlow = Duration(milliseconds: 1200);

  static const Duration splashDuration = Duration(seconds: 4);
  static const Duration transitionDuration = Duration(milliseconds: 1000);

  // Curve presets
  static const Curve easeInOutCubic = Curves.easeInOutCubic;
  static const Curve easeOut = Curves.easeOut;
  static const Curve bounceIn = Curves.bounceIn;
  static const Curve elasticOut = Curves.elasticOut;
}
