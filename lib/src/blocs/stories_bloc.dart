//when creating a bloc make sure to create a provider along with it:

//Bloc uses StreamController using "sink" and "stream"
//RxDart pkg: StreamController = Subject, stream = Observable, now Stream
import 'package:flutter_news_api/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
// import '../models/item_model.dart';

class StoriesBloc {
  final _repository = Repository();
  //Subject fetchs all top ids and makes available for widgets
  //creating the StreamController = PublishSubject:
  final _topIds = PublishSubject<List<int>>();

//Getter to Stream (prev Observable):
  Stream<List<int>> get topIds => _topIds.stream;

//since the repository fetches the info, we will call it and send to sink:

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids!);
  }

//closing instanse of sink ("cleanup"):
  dispose() {
    _topIds.close();
  }
}
