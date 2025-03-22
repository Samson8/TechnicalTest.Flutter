import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task/core/utils/bloc_resource.dart';
import 'package:flutter_tech_task/features/details/presentation/provider/post_details_provider.dart';
import 'package:flutter_tech_task/features/models/post_model.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  dynamic post;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return BlocProvider(
      create: (_) => PostDetailsProvider(args?['id'])..add(LoadPostDetails()),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Post details'),
          ),
          body: BlocBuilder<PostDetailsProvider, AppState>(
              builder: (context, state) {
            if (state is AppLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AppLoaded) {
              final details = PostModel.fromJson(state.data);
              return Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(children: [
                    Text(
                      details.title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Container(height: 10),
                    Text(details.body!, style: const TextStyle(fontSize: 16)),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.comment)),
                          IconButton(
                            icon: Icon(Icons.bookmark_add_outlined),
                            onPressed: () {},
                          )
                        ],
                      ),
                    )
                  ]));
            } else if (state is AppError) {
              return Center(child: Text(state.message ?? ''));
            }
            return Center(child: Text('Nothing to show'));
          })),
    );
  }
}
