import 'package:flutter/material.dart';
import 'package:flutter_tech_task/features/models/comment_model.dart';

class PostComments extends StatelessWidget {
  const PostComments({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Post comments'),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey,
            height: 1,
          ),
          itemCount: (args?['comments'] as List<CommentModel>?)?.length ?? 0,
          itemBuilder: (context, index) {
            return CommentItem(
                commentModel:
                    (args?['comments'] as List<CommentModel>?)?[index]);
          },
        ));
  }
}

class CommentItem extends StatelessWidget {
  final CommentModel? commentModel;
  const CommentItem({super.key, this.commentModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            commentModel?.name ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            commentModel?.email ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(commentModel?.body ?? '', style: const TextStyle(fontSize: 16))
        ],
      ),
    );
  }
}
