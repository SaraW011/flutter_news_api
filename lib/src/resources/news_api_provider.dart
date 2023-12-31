// this class reaches out to 1 of 2 endpoints of api
//  1) list of top ids 2) an item

import 'dart:convert';
import 'package:flutter_news_api/src/models/item_model.dart';
import 'package:http/http.dart';

const _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();
  // var client = Client();

  // topIds will always be fetch externally from api!
  Future<List<int>> fetchTopIds() async {
    var future = client.get(Uri.parse('$_root/topstories.json'));
    final response = await future;
    final ids = json.decode(response.body);
    //gets list of ids:
    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get(Uri.parse('$_root/item/$id.json'));
    final parsedJson = json.decode(response.body);

    //this returns the model:
    return ItemModel.fromJson(parsedJson);
  }
}
