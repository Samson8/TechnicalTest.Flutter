import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tech_task/core/utils/result_handler.dart';
import 'package:flutter_tech_task/features/post/data/post_store_impl.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_store_impl_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late PostStoreImpl postStore;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    postStore = PostStoreImpl(client: mockClient);
  });

  group('getList', () {
    test('returns success with list of posts on valid response', () async {
      const mockResponse = '[{"id": 1, "title": "Test Post"}]';

      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await postStore.getList();

      expect(result, isA<Result>());
      expect(result.data, isNotEmpty);
      expect((result.data as List).first['title'], 'Test Post');
    });

    test('returns failure on exception', () async {
      when(mockClient.get(any)).thenThrow(Exception('Network Error'));

      final result = await postStore.getList();

      expect(result, isA<Result>());
      expect(result.error, contains('Network Error'));
    });
  });
}
