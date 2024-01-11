//when creating a bloc make sure to create a provider along with it:

//Bloc uses StreamController using "sink" and "stream"
//RxDart pc, StreamController = Subject, stream = Observable, now Stream
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  //Subject fetchs all top ids and makes available for widgets
  //creating the PublishSubject (StreamController):
  final _topIds = PublishSubject<List<int>>();

  //Getter to Stream:
  Stream<List<int>> get topIds => _topIds.stream;

//closing instanse of sink ("cleanup"):
  dispose() {
    _topIds.close();
  }
}
