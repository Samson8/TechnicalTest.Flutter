import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task/core/constants/constants.dart';
import 'package:flutter_tech_task/core/utils/bloc_resource.dart';
import 'package:flutter_tech_task/features/details/presentation/provider/post_details_provider.dart';
import 'package:flutter_tech_task/features/models/post_model.dart';
import 'package:flutter_tech_task/features/models/post_with_comments_model.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return BlocProvider(
        create: (_) => PostDetailsProvider()..add(LoadPostDetails(args?['id'])),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Post details'),
          ),
          body: BlocBuilder<PostDetailsProvider, AppState>(
              //get post details from API.
              builder: (context, state) {
            if (args?[Constants.postArgument] != null) {
              return PostDetailItem(
                postWithComments: args?[Constants
                    .postArgument], //display saved post details from route argument
              );
            } else if (state is AppLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AppLoaded) {
              final postWithComments = PostWithComments.fromJson(state.data);
              return PostDetailItem(
                postWithComments: postWithComments,
              );
            } else if (state is AppError) {
              return Center(child: Text(state.message ?? ''));
            }
            return Center(child: Text('Nothing to show'));
          }),
        ));
  }
}

class PostDetailItem extends StatefulWidget {
  final PostWithComments? postWithComments;
  const PostDetailItem({super.key, this.postWithComments});

  @override
  State<PostDetailItem> createState() => _PostDetailItemState();
}

class _PostDetailItemState extends State<PostDetailItem> {
  PostWithComments? postWithComments;
  PostModel? post;

  void showSnackbar(BuildContext context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    postWithComments = widget.postWithComments;
    post = postWithComments?.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            post?.title ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Container(height: 10),
          Text(post?.body ?? '', style: const TextStyle(fontSize: 16)),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Constants.comments,
                          arguments: {'comments': postWithComments?.comments});
                    },
                    icon: Icon(Icons.comment)),
                FutureBuilder<bool>(
                    future: context
                        .read<PostDetailsProvider>()
                        .isPostSaved(post?.id?.toString()),
                    builder: (context, snapshot) {
                      bool isSaved = snapshot.data ?? false;

                      return IconButton(
                        icon: Icon(isSaved
                            ? Icons.bookmark_add
                            : Icons.bookmark_add_outlined),
                        onPressed: () {
                          if (isSaved) {
                            context
                                .read<PostDetailsProvider>()
                                .add(RemovePostOffline(post?.id?.toString()));
                            showSnackbar(
                              context,
                              'Post removed from offline storage',
                            );
                          } else {
                            context
                                .read<PostDetailsProvider>()
                                .add(SavePostOffline(postWithComments!));

                            showSnackbar(
                              context,
                              'Post saved offline!',
                            );
                          }
                          setState(() {
                            isSaved = !isSaved;
                          });
                        },
                      );
                    })
              ],
            ),
          )
        ]));
  }
}
