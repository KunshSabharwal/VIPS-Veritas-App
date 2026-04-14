class FeedbackModel {
  String name;
  String batch;
  String course;
  String topic;
  String teacherName;
  String feedback;
  double rating;

  FeedbackModel({
    required this.name,
    required this.batch,
    required this.course,
    required this.topic,
    required this.teacherName,
    required this.feedback,
    required this.rating,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "batch": batch,
        "course": course,
        "topic": topic,
        "teacherName": teacherName,
        "feedback": feedback,
        "rating": rating,
      };

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      name: json["name"],
      batch: json["batch"],
      course: json["course"],
      topic: json["topic"],
      teacherName: json["teacherName"],
      feedback: json["feedback"],
      rating: (json["rating"] as num).toDouble(),
    );
  }
}
