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

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    FeedbackFormScreen(),
    FeedbackListScreen(),
    ProfileScreen(),
  ];

  BottomNavigationBarItem _navItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: AnimatedScale(
        scale: currentIndex == index ? 1.15 : 1,
        duration: const Duration(milliseconds: 180),
        child: Icon(icon),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFDDE5C5),
              Color(0xFFB7CFA1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: pages[currentIndex],
      ),
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
            selectedFontSize: 12,
            unselectedFontSize: 11,
            onTap: (index) {
              setState(() => currentIndex = index);
            },
            items: [
              _navItem(Icons.home_rounded, "Home", 0),
              _navItem(Icons.edit_outlined, "Feedback", 1),
              _navItem(Icons.list_alt_rounded, "Responses", 2),
              _navItem(Icons.person_outline_rounded, "Profile", 3),
            ],
          ),
        ),
      ),
    );
  }
}
