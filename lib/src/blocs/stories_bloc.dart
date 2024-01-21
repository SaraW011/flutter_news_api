//when creating a bloc make sure to create a provider along with it
//and export this file in provider:

//Bloc uses StreamController using "sink" and "stream"
//RxDart pkg: StreamController = Subject, stream = Observable, now Stream
import 'package:flutter_news_api/src/models/item_model.dart';
import 'package:flutter_news_api/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
// import '../models/item_model.dart';

class StoriesBloc {
  final _repository = Repository();
  //Subject fetchs all top ids and makes available for widgets
  //creating the StreamController = PublishSubject:
  final _topIds = PublishSubject<List<int>>();
//streamcontroller that emits the most recent data event:
  final _items = BehaviorSubject<int>();

//instance var that will hold reference to xformed stream
  late Stream<Map<int, Future<ItemModel>>> items;

//Getter to sink:
  Function(int) get fetchItem => _items.sink.add;

  //GETTER *BAD PRASCTICE* SAMPLE FOR EXPOSING STREAM:!!!!!!!!!!!!!!!!!
  // b/c it runs multiple times when each widget is invoked:
  //every time the widget accesses the getter the function will run
  //and get a cache object that is not shared with other widgets

  // get items => _items.stream.transform(_itemsTransformer());

//_itemsTransformer is called 1 time, creating 1 map cache,
//and re-used for each widget that subscribes to the stream.
//(It returns a new stream but does not modify the org stream):
  storiesBloc() {
    //stream to expose to "outside":
    items = _items.stream.transform(_itemsTransformer());
  }

//Getter to Stream (prev Observable):
  Stream<List<int>> get topIds => _topIds.stream;

//since the repository fetches the info, we will call it and send to sink:

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids!);
  }

// the transformer uses a map key-value object in order to prevent the stateless
// widget from rebuilding every time it receives data from the stream:
// apply EXACTLY 1 TIME! (== not with getter)
  _itemsTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>>? cache, int id, index) {
      //find id and item and add to cache:
      cache?[id] = _repository.fetchItem(id);
      return cache;
    },

        //return empty map:
        <int, Future<ItemModel>>{});
  }

//closing instanse of sink ("cleanup"):
  dispose() {
    _topIds.close();
    _items.close();
  }
}

// accumulated, value, index) => null, seed,
