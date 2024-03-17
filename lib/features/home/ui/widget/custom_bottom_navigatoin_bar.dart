import 'package:flutter/material.dart';
import 'package:x/features/home/logic/home_cubit.dart';

class CustomBottomNavigatoinBar extends StatelessWidget {
  const CustomBottomNavigatoinBar({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        cubit.changeBottom(index);
      },
      currentIndex: cubit.currentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      elevation: 0.0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.notifications_outlined,
          ),
          label: 'notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_bubble_outline,
          ),
          label: 'chat',
        )
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
