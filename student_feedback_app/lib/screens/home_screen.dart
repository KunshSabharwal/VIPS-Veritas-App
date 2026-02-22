import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===============================
            /// TITLE SECTION
            /// ===============================
            Center(
              child: Column(
                children: [
                  Text(
                    "VIPS Veritas",
                    style: textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Speak • Reflect • Improve",
                    style: textTheme.bodyMedium!.copyWith(letterSpacing: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            /// ===============================
            /// GLASS CAMPUS IMAGE CARD
            /// ===============================
            _glassCard(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/college2.jpg",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 28),

            /// ===============================
            /// ABOUT VIPS
            /// ===============================
            _glassCard(
              child: Text(
                "Vivekananda Institute of Professional Studies (VIPS) "
                "is a premier institution focused on innovation, academic "
                "excellence, and holistic student development.",
                textAlign: TextAlign.justify,
                style: textTheme.bodyLarge,
              ),
            ),

            const SizedBox(height: 20),

            /// ===============================
            /// ABOUT APP
            /// ===============================
            _glassCard(
              child: Text(
                "VIPS Veritas allows students to share meaningful feedback "
                "about courses and teaching experiences, helping improve "
                "learning outcomes and academic quality.",
                textAlign: TextAlign.justify,
                style: textTheme.bodyLarge,
              ),
            ),

            const SizedBox(height: 34),

            /// ===============================
            /// INSTITUTE LOGO (BOTTOM)
            /// ===============================
            Center(
              child: Column(
                children: [
                  _glassCard(
                    padding: 14,
                    child: Image.asset(
                      "assets/images/college1.png",
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Vivekananda Institute of Professional Studies",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ===============================
  /// REUSABLE GLASS CARD
  /// ===============================
  Widget _glassCard({required Widget child, double padding = 18}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(padding),
          decoration: AppTheme.glassDecoration,
          child: child,
        ),
      ),
    );
  }
}
