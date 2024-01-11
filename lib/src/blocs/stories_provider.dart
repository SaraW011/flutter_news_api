//provider makes the bloc available anywhere inside the widget tree:

import 'package:flutter/material.dart';
import 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({required Key key, required Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  //the argument of the "bool" is not important, represented with _:
  bool updateShouldNotify(_) => true;

  static StoriesBloc of(BuildContext context) {
    return (context.getInheritedWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;
  }
}
