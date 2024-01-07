import 'dart:async';
import 'package:flutter_news_api/src/resources/news_db_provider.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

//governs access to either of the providers:
class Repository {
  //db must be first initialized and then get data
  //refractored, can now easily work with any number of sources:
  List<Source> sources = <Source>[
    // db:
    NewsApiProvider(),
    // instance of db:
    newsDbProvider,
  ];
  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  //non-refractored, can only work with pre-built sources:
  // NewsDbProvider dbProvider = NewsDbProvider();
  // NewsApiProvider apiProvider = NewsApiProvider();

//does not store top ids, only calls api
  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }
    for (var cache in caches) {
      cache.addItem(item);
    }
    return item;
  }

  //not refractored:
  // Future<ItemModel> fetchItem(int id) async {
  //   var item = await dbProvider.fetchItem(id);
  //   // if (item != null) {
  //   //   return item;
  //   // }
  //   //reasign var "item" to new variable:
  //   item = await apiProvider.fetchItem(id);
  //   dbProvider.addItem(item);
  //   return item;
  // }
}

//create abstrat and import to api_provider:
abstract class Source {
  //same as in "api_provider"
  Future<List<int>>? fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
