import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task/core/constants/constants.dart';
import 'package:flutter_tech_task/core/utils/bloc_resource.dart';
import 'package:flutter_tech_task/features/post/presentation/provider/post_provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostProvider()..add(LoadPosts()),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("List of posts"),
          ),
          body: BlocBuilder<PostProvider, AppState>(builder: (context, state) {
            if (state is AppLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AppLoaded) {
              return ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    final post = state.data[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(Constants.postDetail,
                            arguments: {'id': post.id});
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post['title'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(post['body']),
                            Container(height: 10),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else if (state is AppError) {
              return Center(child: Text(state?.message ?? ''));
            }
            return Center(child: Text('Nothing to show'));
          })),
    );
  }
}
