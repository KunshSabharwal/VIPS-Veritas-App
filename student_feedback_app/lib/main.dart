import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'widgets/animated_app_background.dart';

void main() {
  runApp(const StudentFeedbackApp());
}

class StudentFeedbackApp extends StatelessWidget {
  const StudentFeedbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VIPS Veritas',
      theme: AppTheme.lightTheme,

      builder: (context, child) {
        /// GLOBAL BACKGROUND APPLIED HERE
        return AnimatedAppBackground(child: child ?? const SizedBox());
      },

      home: const SplashScreen(),
    );
  }
}
