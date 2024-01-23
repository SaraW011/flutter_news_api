//listens to item stream, contains future builder:
import 'package:flutter/material.dart';
import 'package:flutter_news_api/src/models/item_model.dart';
import '/src/blocs/stories_provider.dart';
import 'dart:async';

class NewsListTile extends StatelessWidget {
  const NewsListTile({super.key, required this.itmeId});

  final int itmeId;

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return const Text('Stream Loading...');
        }
        throw 'Out of llamas!';
      },
    );
  }
}
