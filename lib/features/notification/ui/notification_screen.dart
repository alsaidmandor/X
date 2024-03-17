import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen(this.scrollController, {super.key});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Notification Screen --------------'),
      ),
    );
  }
}
