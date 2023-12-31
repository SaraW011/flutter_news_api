import 'package:flutter_news_api/src/models/item_model.dart';
import 'package:flutter_news_api/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
//"path_provider" reaches to mobile device local temp directory:
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

//note: asynchronous methods cannot go into a constructor

class NewsDbProvider implements Source, Cache {
  //"Database" comes from sqflite pckg, connects to db on device:
  late Database db;

  //neet this "init" for the "newsDbProvider" instance bellow:
  NewsDbProvider() {
    init();
  }

//to-do: fetch and store top ids:
  @override
  Future<List<int>>? fetchTopIds() {
    return null;
  }

//"init" solves inability of having an async constructor:
  void init() async {
    //package:path_provider, see "Directory" info:
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //creates path to db:
    final path = join(documentsDirectory.path, "items.db");
    //reach out to path or create the db if not on device:
    //onCreate is called only 1st time user access
    db = await openDatabase(path, version: 1,
        // "onCreate" is called b4 db var, therefore initialized with "newDb":
        onCreate: (Database newDb, int version) {
      //initial setup of db
      //sql code for sending arbitrary snippit to db:
      newDb.execute("""
        CREATE TABLE Items
        (
          id INTEGER PRIMARY KEY,
          type TEXT,
          by TEXT,
          time INTEGER,
          text TEXT, 
          parent INTEGER,
          kids BLOB,
          dead INTEGER,
          deleated INTEGER, 
          url TEXT, 
          score INTEGER, 
          title TEXT, 
          descendants INTEGER
        )
         """);
    });
  }

//method takes id and returns an item:
  @override
  Future<ItemModel> fetchItem(int id) async {
    //when we want the entire item, return spesific columns null
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id =?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      //as in "fetchItem" in new_api_provider, map returns a model
      // db is "translated" b/c no bool available (see "item_model"):
      return ItemModel.fromDb(maps.first);
    }
    // return null;
    //cannot return null so:
    throw 'Out of llamas!';
  }

  Future<int> addItem(ItemModel item) {
    return db.insert("Items", item.toMapForDB());
  }
}

//this instance prevents opening multiple connections to db
//(in the Repository class):
//note: missing init
final newsDbProvider = NewsDbProvider();
