import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      // key: key,
      child: const MaterialApp(
        title: 'News!',
        home: NewsList(),
      ),
    );
  }
}
