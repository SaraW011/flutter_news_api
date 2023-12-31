import 'dart:async';
import 'package:flutter_news_api/src/resources/news_db_provider.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

//governs access to either of the providers:
class Repository {
  //db must be first initialized and then get data
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

//does not store top ids, only calls api
  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }
    //reasign var "item" to new variable:
    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);
    return item;
  }
}
