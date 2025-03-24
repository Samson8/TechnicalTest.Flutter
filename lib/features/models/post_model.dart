class PostModel {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  PostModel({this.body, this.id, this.title, this.userId});

  // Factory constructor to create a PostModel from JSON
  factory PostModel.fromJson(Map<String, Object?> json) {
    return PostModel(
      body: json['body'] as String?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      userId: json['userId'] as int?,
    );
  }

  // Convert PostModel to JSON
  Map<String, Object?> toJson() {
    return {
      'body': body,
      'id': id,
      'title': title,
      'userId': userId,
    };
  }
}
