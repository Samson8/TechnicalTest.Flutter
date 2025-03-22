class PostModel {
  final String? userId;
  final String? id;
  final String? title;
  final String? body;
  PostModel({this.body, this.id, this.title, this.userId});

  factory PostModel.fromJson(Map<String, Object?> json) => PostModel(
      body: json['body'] as String?,
      id: json['id'] as String?,
      title: json['title'] as String?,
      userId: json['userId'] as String?);
}
