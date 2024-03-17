import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen(this.scrollController, {super.key});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Chat screen'),
      ),
    );
  }
}
