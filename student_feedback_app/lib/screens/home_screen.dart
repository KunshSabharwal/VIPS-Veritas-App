import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
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
                        style:
                            textTheme.bodyMedium!.copyWith(letterSpacing: 1.4),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                /// IMAGE CARD
                _glassCard(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/img/college2.jpg",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 200,
                          child: Center(child: Text("Image not found")),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                /// ABOUT VIPS
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

                /// ABOUT APP
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

                /// LOGO
                Center(
                  child: Column(
                    children: [
                      _glassCard(
                        padding: 14,
                        child: Image.asset(
                          "assets/img/college1.png",
                          height: 70,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(
                              height: 70,
                              child: Center(child: Text("Image not found")),
                            );
                          },
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
        ),
      ),
    );
  }

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
