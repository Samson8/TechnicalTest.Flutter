import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tech_task/main.dart';
import 'package:flutter_tech_task/core/constants/constants.dart';
import 'package:flutter_tech_task/features/post/presentation/page/post_page.dart';
import 'package:flutter_tech_task/features/post/presentation/page/details_page.dart';
import 'package:flutter_tech_task/features/post/presentation/page/comments.dart';

void main() {
  group('App Initialization Tests', () {
    testWidgets('App starts on ListPage with correct route',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(ListPage), findsOneWidget);
    });
  });

  group('Route Navigation Tests', () {
    testWidgets('Navigates to DetailsPage', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      Navigator.of(tester.element(find.byType(ListPage)))
          .pushNamed(Constants.postDetail, arguments: {'id': "1"});
      await tester.pumpAndSettle();

      expect(find.byType(DetailsPage), findsOneWidget);
    });

    testWidgets('Navigates to PostComments', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle(Duration(seconds: 10));

      Navigator.of(tester.element(find.byType(ListPage)))
          .pushNamed(Constants.comments);
      await tester.pumpAndSettle();

      expect(find.byType(PostComments), findsOneWidget);
    });
  });
}
