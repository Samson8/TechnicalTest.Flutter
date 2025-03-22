class PostModel {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;
  PostModel({this.body, this.id, this.title, this.userId});

  factory PostModel.fromJson(Map<String, Object?> json) => PostModel(
      body: json['body'] as String?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      userId: json['userId'] as int?);
}
