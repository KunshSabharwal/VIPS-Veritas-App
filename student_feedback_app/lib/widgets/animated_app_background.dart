import 'package:flutter/material.dart';

class AnimatedAppBackground extends StatefulWidget {
  final Widget child;

  const AnimatedAppBackground({super.key, required this.child});

  @override
  State<AnimatedAppBackground> createState() => _AnimatedAppBackgroundState();
}

class _AnimatedAppBackgroundState extends State<AnimatedAppBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1 + controller.value, -1),
              end: Alignment(1, 1 - controller.value),
              colors: const [
                Color(0xFFF1F3E0), // light cream
                Color(0xFFD2DCB6), // pastel green
                Color(0xFFA1BC98), // soft green
                Color(0xFF778873), // muted deep green
              ],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
