import 'package:sqflite/sqflite.dart';
//"path_provider" reaches to mobile device local temp directory:
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

//note: asynchronous methods cannot go into a constructor

class NewsDbProvider {
  //"Database" comes from sqflite pckg, connects to db on device:
  late Database db;
//"init" solves inability of async constructor:
  init() async {
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
}
