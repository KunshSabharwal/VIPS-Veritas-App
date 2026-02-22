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

class _FeedbackListScreenState extends State<FeedbackListScreen> {
  /// STAR DISPLAY
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

  /// GLASS CARD
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

  /// ---------------- VIEW FEEDBACK ----------------
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
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              if (item.teacherName.isNotEmpty)
                Text(
                  item.teacherName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
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

  /// ---------------- EDIT FEEDBACK ----------------
  void editFeedback(int index) {
    final item = FeedbackData.feedbackList[index];
    final controller = TextEditingController(text: item.feedback);

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 26, 24, 22),
          decoration: AppTheme.glassDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
              Text(
                "Edit Feedback",
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 6),

              Text(
                "Update feedback",
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 18),

              /// TEXT FIELD (NO OVERLAP NOW)
              TextField(
                controller: controller,
                maxLines: 5,
                style: const TextStyle(fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: "Edit your feedback...",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    child: const Text("Save"),
                    onPressed: () {
                      setState(() {
                        item.feedback = controller.text;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- DELETE CONFIRM ----------------
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
              const Text(
                "Are you sure you want to permanently delete this feedback?",
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        FeedbackData.feedbackList.removeAt(index);
                      });
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

  /// ---------------- POPUP MENU ----------------
  void showOptions(BuildContext context, Offset position, int index) async {
    final selected = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: const [
        PopupMenuItem(value: "view", child: Text("View Feedback")),
        PopupMenuItem(value: "edit", child: Text("Edit Feedback")),
        PopupMenuItem(
          value: "delete",
          child: Text("Delete Feedback", style: TextStyle(color: Colors.red)),
        ),
      ],
    );

    if (selected == "view") viewFeedback(FeedbackData.feedbackList[index]);
    if (selected == "edit") editFeedback(index);
    if (selected == "delete") confirmDelete(index);
  }

  /// ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    final list = FeedbackData.feedbackList;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Your Feedback",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: list.isEmpty
                    ? const Center(child: Text("No feedback submitted yet."))
                    : ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final item = list[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: glassCard(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.topic == "Teacher"
                                            ? "Teacher Feedback"
                                            : item.topic,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Builder(
                                        builder: (btnContext) => IconButton(
                                          icon: const Icon(Icons.more_vert),
                                          onPressed: () {
                                            final RenderBox button =
                                                btnContext.findRenderObject()
                                                    as RenderBox;

                                            final RenderBox overlay =
                                                Overlay.of(
                                              context,
                                            ).context.findRenderObject()
                                                    as RenderBox;

                                            final position =
                                                RelativeRect.fromRect(
                                              Rect.fromPoints(
                                                button.localToGlobal(
                                                  Offset.zero,
                                                  ancestor: overlay,
                                                ),
                                                button.localToGlobal(
                                                  button.size.bottomRight(
                                                    Offset.zero,
                                                  ),
                                                  ancestor: overlay,
                                                ),
                                              ),
                                              Offset.zero & overlay.size,
                                            );

                                            showOptions(
                                              context,
                                              Offset(
                                                position.left,
                                                position.top,
                                              ),
                                              index,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (item.teacherName.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        item.teacherName,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  buildStars(item.rating),
                                ],
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
    );
  }
}
