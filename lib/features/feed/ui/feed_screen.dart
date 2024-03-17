import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen(this.scrollController, {super.key});

  final ScrollController scrollController;

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Feed Screen----------------'),
      ),
    );
  }
}
