import 'package:flutter/material.dart';
import 'package:flutter_tech_task/core/constants/constants.dart';
import 'package:flutter_tech_task/core/injections.dart';
import 'package:flutter_tech_task/features/details/presentation/page/details_page.dart';
import 'package:flutter_tech_task/features/post/presentation/page/post_page.dart';

void main() async {
  await initInjections();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Constants.postList,
      routes: {
        Constants.postList: (context) => ListPage(),
        Constants.postDetail: (context) => DetailsPage(),
      },
    );
  }
}
