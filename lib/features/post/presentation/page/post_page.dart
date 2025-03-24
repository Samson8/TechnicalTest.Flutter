import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task/core/constants/constants.dart';
import 'package:flutter_tech_task/core/utils/bloc_resource.dart';
import 'package:flutter_tech_task/features/models/post_model.dart';
import 'package:flutter_tech_task/features/models/post_with_comments_model.dart';
import 'package:flutter_tech_task/features/post/presentation/provider/post_provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  BuildContext? providerBuildContext;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (_tabController.index == 1 && mounted) {
          setState(() {
            // need to setState ensure using updated context
            providerBuildContext?.read<PostProvider>().add(LoadPosts());
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostProvider()..add(LoadPosts()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("List of Posts"),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'API Posts'),
              Tab(text: 'Saved Posts'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Tab 1 - API Posts
            BlocBuilder<PostProvider, AppState>(
              builder: (context, state) {
                providerBuildContext = context;

                if (state is AppLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AppLoaded) {
                  return ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final post = PostModel.fromJson(state.data[index]);
                      return PostItem(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            Constants.postDetail,
                            arguments: {'id': post.id.toString()},
                          );
                        },
                        post: post,
                      );
                    },
                  );
                } else if (state is AppError) {
                  return Center(
                      child: Text(state.message ?? 'Error loading posts'));
                }
                return const Center(child: Text('No data available'));
              },
            ),
            // Tab 2 - Saved Posts
            FutureBuilder<List<PostWithComments>>(
              future:
                  providerBuildContext?.read<PostProvider>().getSavedPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data![index].post;
                      return PostItem(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            Constants.postDetail,
                            arguments: {
                              Constants.postArgument: snapshot.data![index]
                            },
                          );
                        },
                        post: post,
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No saved posts available.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final PostModel? post;
  final VoidCallback? onTap;
  const PostItem({super.key, this.post, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post?.title ?? 'Nil',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(post?.body ?? 'Nil'),
            const Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
