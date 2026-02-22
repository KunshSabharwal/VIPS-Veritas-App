import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// ANIMATED GRADIENT
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
    _controller.dispose();
    super.dispose();
  }

  /// ---------- LINKS ----------
  Future<void> openLinkedIn() async {
    final url = Uri.parse("https://www.linkedin.com/in/kunshsabharwal/");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Future<void> openGithub() async {
    final url = Uri.parse("https://github.com/KunshSabharwal");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  /// ---------- GLASS CARD ----------
  Widget glassCard(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: AppTheme.glassDecoration,
            child: Row(
              children: [
                Icon(icon, size: 26, color: AppTheme.primaryText),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        value,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
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

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// SAME APP GRADIENT (NOW CONNECTS WITH NAVBAR)
        AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.lerp(
                      AppTheme.bgLight,
                      AppTheme.softSage,
                      _controller.value,
                    )!,
                    Color.lerp(
                      AppTheme.softSage,
                      AppTheme.pastelGreen,
                      _controller.value,
                    )!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            );
          },
        ),

        /// CONTENT
        SafeArea(
          bottom: false, // IMPORTANT → lets gradient go behind navbar
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
            child: Column(
              children: [
                /// PROFILE HEADER
                Column(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: AppTheme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Kunsh Sabharwal",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Flutter Developer • AIML Student",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// INFO CARDS
                glassCard(
                  Icons.school,
                  "Institute",
                  "Vivekananda Institute of Professional Studies",
                ),
                glassCard(
                  Icons.computer,
                  "Branch",
                  "Artificial Intelligence & Machine Learning",
                ),
                glassCard(
                  Icons.psychology,
                  "Skills",
                  "Flutter • Python • Deep Learning • AI",
                ),
                glassCard(
                  Icons.apps,
                  "Project",
                  "VIPS Veritas — Student Feedback Platform",
                ),

                const SizedBox(height: 25),

                /// CONNECT
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Connect With Me",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),

                const SizedBox(height: 16),

                ElevatedButton.icon(
                  onPressed: openLinkedIn,
                  icon: const Icon(Icons.work_outline),
                  label: const Text("LinkedIn"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                  ),
                ),

                const SizedBox(height: 12),

                OutlinedButton.icon(
                  onPressed: openGithub,
                  icon: const Icon(Icons.code),
                  label: const Text("GitHub"),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                    foregroundColor: AppTheme.primaryText,
                    side: BorderSide(color: AppTheme.primaryText),
                  ),
                ),

                const SizedBox(height: 30),

                /// DEV BADGE
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: AppTheme.glassDecoration,
                  child: Text(
                    "Developed by Kunsh Sabharwal • v1.0.0",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
