import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'feedback_model.dart';

class FeedbackData {
  static List<FeedbackModel> feedbackList = [];

  static const String key = "feedback_list_admin";

  static Future<void> saveFeedbacks() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> data =
        feedbackList.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, data);
  }

  static Future<void> loadFeedbacks() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(key);

    if (data != null) {
      feedbackList =
          data.map((e) => FeedbackModel.fromJson(jsonDecode(e))).toList();
    }
  }
}
