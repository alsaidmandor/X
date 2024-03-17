import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen(this.scrollController, {super.key});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Search screen -------------'),
      ),
    );
  }
}
