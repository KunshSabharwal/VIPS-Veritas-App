import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/feedback_data.dart';
import '../models/feedback_model.dart';
import '../theme/app_theme.dart';

class FeedbackFormScreen extends StatefulWidget {
  const FeedbackFormScreen({super.key});

  @override
  State<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final teacherController = TextEditingController();
  final feedbackController = TextEditingController();

  String? batch;
  String? course;
  String? topic;

  int rating = 3;
  bool submitting = false;

  late AnimationController _pageController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    _pageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    fadeAnimation = CurvedAnimation(
      parent: _pageController,
      curve: Curves.easeIn,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _pageController, curve: Curves.easeOut));

    _pageController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// 🧊 GLASS WRAPPER
  Widget glassSection(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: AppTheme.glassDecoration,
          child: child,
        ),
      ),
    );
  }

  /// STAR RATING
  Widget buildStarRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Rate your experience",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            final starIndex = index + 1;

            return GestureDetector(
              onTap: () => setState(() => rating = starIndex),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutBack,
                scale: rating == starIndex ? 1.3 : 1,
                child: Icon(
                  starIndex <= rating
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  color: Colors.amber,
                  size: 34,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  /// ---------- SUBMIT ----------
  Future<void> submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => submitting = true);

    await Future.delayed(const Duration(milliseconds: 900));

    FeedbackData.feedbackList.add(
      FeedbackModel(
        name: nameController.text,
        batch: batch!,
        course: course!,
        topic: topic!,
        teacherName: topic == "Teacher" ? teacherController.text : "",
        feedback: feedbackController.text,
        rating: rating.toDouble(),
      ),
    );

    setState(() => submitting = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SuccessDialog(),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);

      _formKey.currentState!.reset();
      nameController.clear();
      teacherController.clear();
      feedbackController.clear();

      setState(() {
        batch = null;
        course = null;
        topic = null;
        rating = 3;
      });
    });
  }

  /// ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Center(
                    child: Text(
                      "Give Feedback",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// 🧊 FORM CARD
                  glassSection(
                    Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Student Name",
                          ),
                          validator: (v) => v!.isEmpty ? "Enter name" : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: batch,
                          decoration: const InputDecoration(labelText: "Batch"),
                          items: const [
                            DropdownMenuItem(
                              value: "2023-2027",
                              child: Text("2023–2027"),
                            ),
                            DropdownMenuItem(
                              value: "2024-2028",
                              child: Text("2024–2028"),
                            ),
                            DropdownMenuItem(
                              value: "2025-2029",
                              child: Text("2025–2029"),
                            ),
                          ],
                          onChanged: (v) => setState(() => batch = v),
                          validator: (v) => v == null ? "Select batch" : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: course,
                          decoration: const InputDecoration(
                            labelText: "Course",
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "AIML",
                              child: Text("AIML"),
                            ),
                            DropdownMenuItem(
                              value: "AIDS",
                              child: Text("AIDS"),
                            ),
                            DropdownMenuItem(value: "CSE", child: Text("CSE")),
                            DropdownMenuItem(
                              value: "IIOT",
                              child: Text("IIOT"),
                            ),
                          ],
                          onChanged: (v) => setState(() => course = v),
                          validator: (v) => v == null ? "Select course" : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: topic,
                          decoration: const InputDecoration(
                            labelText: "Feedback Topic",
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "Teacher",
                              child: Text("Teacher"),
                            ),
                            DropdownMenuItem(
                              value: "Infrastructure",
                              child: Text("Campus Infrastructure"),
                            ),
                            DropdownMenuItem(
                              value: "Timetable",
                              child: Text("Timetable"),
                            ),
                            DropdownMenuItem(
                              value: "Management",
                              child: Text("Management"),
                            ),
                            DropdownMenuItem(
                              value: "General",
                              child: Text("General"),
                            ),
                          ],
                          onChanged: (v) => setState(() => topic = v),
                          validator: (v) => v == null ? "Select topic" : null,
                        ),
                        const SizedBox(height: 18),
                        if (topic == "Teacher") ...[
                          TextFormField(
                            controller: teacherController,
                            decoration: const InputDecoration(
                              labelText: "Teacher Name",
                            ),
                            validator: (v) =>
                                v!.isEmpty ? "Enter teacher name" : null,
                          ),
                          const SizedBox(height: 16),
                          buildStarRating(),
                        ],
                        if (topic != null && topic != "Teacher") ...[
                          buildStarRating(),
                          const SizedBox(height: 16),
                        ],
                        TextFormField(
                          controller: feedbackController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            labelText: "Write your feedback",
                          ),
                          validator: (v) =>
                              v!.isEmpty ? "Enter feedback" : null,
                        ),
                        const SizedBox(height: 26),
                        AnimatedScale(
                          duration: const Duration(milliseconds: 200),
                          scale: submitting ? 0.95 : 1,
                          child: SizedBox(
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: submitting ? null : submitFeedback,
                              child: submitting
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text("Submit Feedback"),
                            ),
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
      ),
    );
  }
}

/// ✅ PREMIUM SUCCESS DIALOG
class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: AppTheme.glassDecoration,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.green, size: 75),
                SizedBox(height: 12),
                Text(
                  "Feedback Submitted!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
