import 'package:flutter_tech_task/features/models/comment_model.dart';
import 'package:flutter_tech_task/features/models/post_model.dart';

class PostWithComments {
  final PostModel? post;
  final List<CommentModel>? comments;

  PostWithComments({this.post, this.comments});

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'post': post?.toJson(),
      'comments': comments?.map((comment) => comment.toJson()).toList(),
    };
  }

  // Factory constructor to create an instance from JSON
  factory PostWithComments.fromJson(Map<String, dynamic> map) {
    return PostWithComments(
      post: PostModel.fromJson(map['post'] as Map<String, dynamic>),
      comments: (map['comments'] as List<dynamic>)
          .map((comment) =>
              CommentModel.fromJson(comment as Map<String, dynamic>))
          .toList(),
    );
  }
}
