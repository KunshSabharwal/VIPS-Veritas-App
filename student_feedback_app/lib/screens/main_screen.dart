import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'feedback_form_screen.dart';
import 'feedback_list_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  AnimationController? _controller;

  final List<Widget> pages = const [
    HomeScreen(),
    FeedbackFormScreen(),
    FeedbackListScreen(),
    ProfileScreen(),
  ];

  @override
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  BottomNavigationBarItem _navItem(IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller!,
            builder: (_, __) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(
                        AppTheme.bgLight,
                        AppTheme.softSage,
                        _controller!.value,
                      )!,
                      Color.lerp(
                        AppTheme.softSage,
                        AppTheme.pastelGreen,
                        _controller!.value,
                      )!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),

          /// PAGE CONTENT
          pages[currentIndex],
        ],
      ),

      /// GLASS NAVBAR
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(14),
        decoration: AppTheme.glassDecoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppTheme.primaryText,
            unselectedItemColor: Colors.black45,
            onTap: (index) => setState(() => currentIndex = index),
            items: [
              _navItem(Icons.home_rounded, "Home"),
              _navItem(Icons.edit_outlined, "Give Feedback"),
              _navItem(Icons.list_alt_rounded, "View Feedback"),
              _navItem(Icons.person_outline_rounded, "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
