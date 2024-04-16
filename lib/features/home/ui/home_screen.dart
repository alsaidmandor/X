import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/core/helper/extensions.dart';
import 'package:x/features/home/ui/widget/home_screen_drawer.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/app_icons.dart';
import '../../../core/theming/colors.dart';
import '../../../core/widget/x_logo.dart';
import '../logic/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late ScrollController _scrollController;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isVisible = true;
        });
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }

        if (state is HomeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Get Profile Successful'),
          ));
        }
      },
      builder: (context, state) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 2,
                title: const XLogo(),
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: ColorsManager.mainBlue,
                    radius: 10,
                    backgroundImage: cubit.userModel != null
                        ? NetworkImage(
                            cubit.userModel!.profilePic!,
                          )
                        : null,
                  ).onTap(() {
                    scaffoldKey.currentState!.openDrawer();
                  }),
                ),
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(AppIcon.settings)),
                ],
              ),
              drawer: HomeScreenDrawer(cubit: cubit),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottom(index);
                },
                selectedItemColor: ColorsManager.mainBlue,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: Colors.white,
                elevation: 5,
                iconSize: 25,
                items: [
                  BottomNavigationBarItem(
                      icon: cubit.currentIndex == 0
                          ? const Icon(AppIcon.homeFill)
                          : const Icon(AppIcon.home),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: cubit.currentIndex == 1
                          ? const Icon(AppIcon.searchFill)
                          : const Icon(AppIcon.search),
                      label: 'search'),
                  BottomNavigationBarItem(
                      icon: cubit.currentIndex == 2
                          ? const Icon(AppIcon.notificationFill)
                          : const Icon(AppIcon.notification),
                      label: 'notification'),
                  BottomNavigationBarItem(
                      icon: cubit.currentIndex == 3
                          ? const Icon(AppIcon.chatFill)
                          : const Icon(AppIcon.chat),
                      label: 'chat'),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.pushNamed(Routes.createPostScreen);
                },
                backgroundColor: ColorsManager.mainBlue,
                child: const Icon(
                  AppIcon.fabTweet,
                  color: Colors.white,
                ),
              ),
              body: cubit.bottomScreens(_scrollController)[cubit.currentIndex],
            );
          },
        );
      },
    );
  }
}
