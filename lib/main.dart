import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task/core/constants/constants.dart';
import 'package:flutter_tech_task/core/injections.dart';
import 'package:flutter_tech_task/features/post/presentation/page/comments.dart';
import 'package:flutter_tech_task/features/post/presentation/page/details_page.dart';
import 'package:flutter_tech_task/features/post/presentation/page/post_page.dart';
import 'package:flutter_tech_task/features/post/presentation/provider/post_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjections();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostProvider()..add(LoadPosts()),
      child: MaterialApp(
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: Constants.postList,
        routes: {
          Constants.postList: (context) => ListPage(),
          Constants.postDetail: (context) => DetailsPage(),
          Constants.comments: (context) => PostComments(),
        },
      ),
    );
  }
}
