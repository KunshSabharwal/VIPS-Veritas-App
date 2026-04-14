import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/feedback_data.dart';
import '../models/feedback_model.dart';
import '../theme/app_theme.dart';

class FeedbackListScreen extends StatefulWidget {
  const FeedbackListScreen({super.key});

  @override
  State<FeedbackListScreen> createState() => _FeedbackListScreenState();
}

class _FeedbackListScreenState extends State<FeedbackListScreen>
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

    fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

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

  Widget buildStars(double rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star_rounded : Icons.star_border_rounded,
          color: Colors.amber,
          size: 22,
        ),
      ),
    );
  }

  Widget glassCard(Widget child) {
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

  void viewFeedback(FeedbackModel item) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: glassCard(
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.topic == "Teacher" ? "Teacher Feedback" : item.topic,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              if (item.teacherName.isNotEmpty)
                Text(item.teacherName,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Text(item.feedback),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: glassCard(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Delete Feedback",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text("Are you sure you want to delete this feedback?"),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel")),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async {
                      setState(() {
                        FeedbackData.feedbackList.removeAt(index);
                      });

                      await FeedbackData.saveFeedbacks();

                      Navigator.pop(context);
                    },
                    child: const Text("Delete"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = FeedbackData.feedbackList;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Your Feedback",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: list.isEmpty
                        ? const Center(
                            child: Text("No feedback submitted yet."),
                          )
                        : ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final item = list[index];

                              return Dismissible(
                                key: Key("${item.name}-$index"),
                                direction: DismissDirection.horizontal,
                                background: Container(
                                  margin: const EdgeInsets.only(bottom: 18),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.visibility,
                                          color: Colors.green),
                                      SizedBox(width: 8),
                                      Text("View",
                                          style:
                                              TextStyle(color: Colors.green)),
                                    ],
                                  ),
                                ),
                                secondaryBackground: Container(
                                  margin: const EdgeInsets.only(bottom: 18),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Delete",
                                          style: TextStyle(color: Colors.red)),
                                      SizedBox(width: 8),
                                      Icon(Icons.delete, color: Colors.red),
                                    ],
                                  ),
                                ),
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    viewFeedback(item);
                                    return false;
                                  } else {
                                    confirmDelete(index);
                                    return false;
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 18),
                                  child: glassCard(
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.topic,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        if (item.teacherName.isNotEmpty)
                                          Text(
                                            item.teacherName,
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          ),
                                        const SizedBox(height: 6),
                                        buildStars(item.rating),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
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
