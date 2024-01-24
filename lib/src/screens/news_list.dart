import 'package:flutter/material.dart';
import 'package:flutter_news_api/src/widgets/news_list_tile.dart';
// import '/src/blocs/stories_bloc.dart';
import '/src/blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(context) {
    //context is refrenced up the widget hierarchy:
    final bloc = StoriesProvider.of(context);
///////////////////////// BAD PRACTICE
    bloc.fetchTopIds();

    // BAD PRACTICE////////////////////////
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top News',
        ),
      ),
      body: buildList(bloc),
      // body: const Text("this is where the bloc is"),
    );
  }

//helper method, bloc testing:
  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
        stream: bloc.topIds,
        builder: (context, AsyncSnapshot<List<int>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, int index) {
              bloc.fetchItem(snapshot.data![index]);
              return NewsListTile(
                itemId: snapshot.data![index],
              );
            },
          );
        });
  }
}
