import 'dart:async';
import 'package:flutter_news_api/src/resources/news_db_provider.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  //db must be first initialized and then get data
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  fetchTopIds() {}
  fetchItem() {}
}
