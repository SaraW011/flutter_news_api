//provider makes the bloc available anywhere inside the widget tree
//make sure to export bloc from here as well:

import 'package:flutter/material.dart';
import 'stories_bloc.dart';
export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({Key? key, required Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  //the argument of the "bool" is not important, represented with "oldWidget":
  @override
  bool updateShouldNotify(oldWidget) => true;

//get access to this bloc at any location in widget hierarchy:
  static StoriesBloc of(BuildContext context) {
    return (context.getInheritedWidgetOfExactType(
            // StoriesProvider
            ) as StoriesProvider)
        .bloc;
  }
}
