class CommentModel {
  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  CommentModel({this.body, this.email, this.id, this.name, this.postId});

  // Factory constructor to create a CommentModel from JSON
  factory CommentModel.fromJson(Map<String, dynamic> map) {
    return CommentModel(
      postId: map['postId'] as int?,
      id: map['id'] as int?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      body: map['body'] as String?,
    );
  }

  // Convert CommentModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }
}
