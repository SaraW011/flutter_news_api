import 'package:flutter_news_api/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('fetchTopIds returns a list of ids', () {
    //setup of test case
    //better if test doesn't reach out to external api,
    //so use http package "MockClient" to complete test without reachig external
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient(
      (request) async => Response(json.encode([1, 2, 3, 4]), 200),
    );
    final ids = newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });
}
