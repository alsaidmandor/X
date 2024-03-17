import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x/core/helper/extensions.dart';
import 'package:x/core/helper/spacing.dart';
import 'package:x/core/routing/routes.dart';
import 'package:x/core/theming/styles.dart';
import 'package:x/core/widget/app_text_botton.dart';

import '../../../../core/theming/app_icons.dart';
import '../../logic/home_cubit.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Padding(
            padding: EdgeInsets.only(top: 10.h, left: 10.h, right: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        cubit.userModel!.profilePic!,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          buildShowModelBottomSheet(context);
                        },
                        icon: const Icon(Icons.more_horiz))
                  ],
                ),
                verticalSpace(5.h),
                Text(cubit.userModel!.displayName!,
                    style: TextStyles.font19DarkBlue_2Bold),
                Text(
                  cubit.userModel!.userName!,
                  style: TextStyles.font16BlackRegular.copyWith(height: 0.5),
                ),
                verticalSpace(10.h),
                Text.rich(
                    style: TextStyles.font16BlackRegular,
                    TextSpan(children: [
                      TextSpan(
                          text: '${cubit.userModel!.following ?? 0} : ',
                          style: TextStyles.font16BlackRegular),
                      TextSpan(
                          text: 'Following',
                          style: TextStyles.font14LightGrayRegular
                              .copyWith(color: Colors.grey)),
                      TextSpan(
                          text: ' | ', style: TextStyles.font16BlackRegular),
                      TextSpan(
                          text: '${cubit.userModel!.followers ?? 0} : ',
                          style: TextStyles.font16BlackRegular),
                      TextSpan(
                          text: 'Followers',
                          style: TextStyles.font14LightGrayRegular
                              .copyWith(color: Colors.grey)),
                    ]))
              ],
            ),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.h),
          title: Text(
            'Profile',
            style: TextStyles.font24BlackBold,
          ),
          leading: const Icon(
            AppIcon.profile,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.h),
          title: Text(
            'Lists',
            style: TextStyles.font24BlackBold,
          ),
          leading: Icon(
            AppIcon.lists,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.h),
          title: Text(
            'Bookmarks',
            style: TextStyles.font24BlackBold,
          ),
          leading: Icon(
            AppIcon.bookmark,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.h),
          title: Text(
            'Moments',
            style: TextStyles.font24BlackBold,
          ),
          leading: Icon(
            AppIcon.moments,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const Divider(
          height: 1,
        ),
        ListTile(
          title: const Text('Settings and privacy'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Help center'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }

  void buildShowModelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      elevation: 0.0,
      constraints: BoxConstraints(
        maxHeight: ScreenUtil().screenHeight * 0.4.h,
        minHeight: ScreenUtil().screenHeight * 0.3.h,
        minWidth: ScreenUtil().screenWidth,
      ),
      showDragHandle: true,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Accounts',
                  style: TextStyles.font24BlackBold,
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(cubit.userModel!.profilePic!),
                  ),
                  horizontalSpace(10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(cubit.userModel!.displayName!,
                          style: TextStyles.font19DarkBlue_2Bold),
                      Text(
                        cubit.userModel!.userName!,
                        style: TextStyles.font16BlackRegular,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15.sp,
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              AppTextButton(
                  buttonText: 'Create a new account ',
                  textStyle: TextStyles.font16BlackRegular,
                  borderRadius: 12,
                  isBorderSide: true,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    context.pushNamed(Routes.signUpScreen);
                  }),
              verticalSpace(5.h),
              AppTextButton(
                  buttonText: 'Add an existing account ',
                  textStyle: TextStyles.font16BlackRegular,
                  borderRadius: 12,
                  isBorderSide: true,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    context.pushNamed(Routes.loginScreen);
                  }),
            ],
          ),
        );
      },
    );
  }
}
