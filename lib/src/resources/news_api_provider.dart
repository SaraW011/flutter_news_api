// this class reaches out to 1 of 2 endpoints of api
//  1) list of top ids 2) an item

import 'dart:convert';
import 'package:flutter_news_api/src/models/item_model.dart';
import 'package:http/http.dart' show Client;

const _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();
  fetchTopIds() async {
    final response = await client.get('$_root/topstories.json' as Uri);
    final ids = json.decode(response.body);
    //gets list of ids:
    return ids;
  }

  fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json' as Uri);
    final parsedJson = json.decode(response.body);

    //this returns the model:
    return ItemModel.fromJson(parsedJson);
  }
}
