import 'dart:js';

import 'package:flutter/material.dart';
// import '/src/blocs/stories_bloc.dart';
import '/src/blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    //context is refrenced up the widget hierarchy:
    final bloc = StoriesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

//helper method, bloc testing:
  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
        stream: bloc.topIds,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('Still waiting on IDs');
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, int index) {
              return Text(snapshot.data?[index] as String);
            },
          );
        });
  }
}
