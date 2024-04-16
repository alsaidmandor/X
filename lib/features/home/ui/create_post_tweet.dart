import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x/core/helper/extensions.dart';
import 'package:x/core/utilits/constants_image.dart';
import 'package:x/core/widget/custom_app_bar.dart';
import 'package:x/features/home/ui/widget/composeBottomIconWidget.dart';
import 'package:x/features/home/ui/widget/composeTweetImage.dart';
import 'package:x/features/home/ui/widget/widgetView.dart';

import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/utilits/utility.dart';
import '../../../core/widget/custom_image_circle.dart';
import '../../sign_up/data/models/user_model.dart';
import '../data/models/feedModel.dart';
import '../logic/home_cubit.dart';

class CreatePostTweet extends StatefulWidget {
  CreatePostTweet({Key? key, required this.isRetweet, this.isTweet = true})
      : super(key: key);

  final bool isRetweet;
  final bool isTweet;

  @override
  _ComposeTweetReplyPageState createState() => _ComposeTweetReplyPageState();
}

class _ComposeTweetReplyPageState extends State<CreatePostTweet> {
  // File? _image;
  late TextEditingController _textEditingController;
  late ScrollController scrollController;
  bool isScrollingDown = false;
  late FeedModel? model;

  File? imagePath;
  String? imageUrl;

  Future<void> _submitButton(BuildContextcontext) async {
    if (_textEditingController.text.length > 280) {
      return;
    }
    FeedModel tweetModel = await createTweetModel();
    String? tweetId;
    imagePath = HomeCubit.get(context).tweetImage;
    if (imagePath != null) {
      imageUrl = await HomeCubit.get(context).emitUploadImageStates(imagePath);
    }
    if (imageUrl != null) {
      // String? imageUrl = HomeCubit.get(context).imageUrl;
      // print(imageUrl);
      tweetModel.imagePath = imageUrl;

      if (imageUrl != null) {
        /// If type of tweet is new tweet
        if (widget.isTweet) {
          HomeCubit.get(context).emitCreateTweetStates(tweetModel);
        }
      }
    } else {
      /// If type of tweet is new tweet
      if (widget.isTweet) {
        HomeCubit.get(context).emitCreateTweetStates(tweetModel);
      }
    }
    // context.pop();
    // _textEditingController.clear();
  }

  void _onImageIconSelected(File file) {
    setState(() {
      // _image = file;
    });
  }

  void _onCrossIconPressed() {
    HomeCubit.get(context).clearTweetImage();
  }

  void _onSubmitButtonPressed(BuildContext context) {
    context.pop();
    _textEditingController.text = '';
    HomeCubit.get(context).clearTweetImage();
  }

  Future<FeedModel> createTweetModel() async {
    var cubit = HomeCubit.get(context);
    var myUser = HomeCubit.get(context).userModel;
    var profilePic = myUser!.profilePic ?? ConstantsImage.dummyProfilePic;

    /// User who are creating reply tweet
    var commentedUser = UserModel(
        displayName: myUser.displayName ?? myUser.email!.split('@')[0],
        profilePic: profilePic,
        userId: myUser.userId,
        isVerified: cubit.userModel!.isVerified,
        userName: cubit.userModel!.userName);
    var tags = Utility.getHashTags(_textEditingController.text);
    FeedModel reply = FeedModel(
        description: _textEditingController.text,
        lanCode: null,
        city: cubit.city,
        country: cubit.country,
        user: commentedUser,
        createdAt: DateTime.now().toUtc().toString(),
        tags: tags,
        parentkey: widget.isTweet
            ? null
            : widget.isRetweet
                ? null
                : cubit.tweetToReplyModel!.key,
        childRetwetkey: widget.isTweet
            ? null
            : widget.isRetweet
                ? model!.key
                : null,
        userId: myUser.userId!);
    return reply;
  }

  @override
  void initState() {
    super.initState();
    model = context.read<HomeCubit>().tweetToReplyModel;
    scrollController = ScrollController();
    _textEditingController = TextEditingController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!isScrollingDown) {
        HomeCubit.get(context).setIsScrollingDown = true;
      }
    }
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      HomeCubit.get(context).setIsScrollingDown = false;
    }
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Tweet Successful'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Congratulations, you create tweet successfully!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
              ),
              onPressed: () {
                context.pop();
                _onSubmitButtonPressed(context);
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error,
          style: TextStyles.font15DarkBlueMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Got it',
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeSuccessCreateTweet) {
          print(state.id);
          showSuccessDialog(context);
        }
        if (state is HomeErrorCreateTweet) {
          setupErrorState(context, state.error);
        }
      },
      builder: (context, state) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return Scaffold(
                appBar: CustomAppBar(
                    title: Text(''),
                    onActionPressed: () => _submitButton(context),
                    isCrossButton: true,
                    submitButtonText: widget.isTweet
                        ? 'Tweet'
                        : widget.isRetweet
                            ? 'Retweet'
                            : 'Reply',
                    isSubmitDisable: cubit.enableSubmitButton,
                    isBottomLine: cubit.isScrollingDown),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          _ComposeTweet(this),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ComposeBottomIconWidget(
                          textEditingController: _textEditingController,
                          onImageIconSelected: _onImageIconSelected),
                    )
                  ],
                ));
          },
        );
      },
    );
  }
}

// ComposeTweet
class _ComposeTweet
    extends WidgetView<CreatePostTweet, _ComposeTweetReplyPageState> {
  const _ComposeTweet(this.viewState) : super(viewState);

  final _ComposeTweetReplyPageState viewState;

  Widget _widgetCard() {
    return Container(
      child: Row(children: [
        const SizedBox(
          width: 10,
        ),
        const CustomImageCircle(
          path: null,
          height: 50,
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Container(
          height: context.height,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              viewState.widget.isTweet
                  ? const SizedBox.shrink()
                  : _widgetCard(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageCircle(
                    path: cubit.userModel!.profilePic!,
                    height: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: _TextField(
                    isTweet: widget.isTweet,
                    textEditingController: viewState._textEditingController,
                  )),
                ],
              ),
              Flexible(
                child: Stack(
                  children: <Widget>[
                    ComposeTweetImage(
                      image: cubit.tweetImage,
                      onCrossIconPressed: viewState._onCrossIconPressed,
                    ),
                    // _UserList(
                    //   list: cubit.listUser,
                    //   textEditingController: viewState._textEditingController,
                    // )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField(
      {Key? key,
      required this.textEditingController,
      this.isTweet = false,
      this.isRetweet = false})
      : super(key: key);
  final TextEditingController textEditingController;
  final bool isTweet;
  final bool isRetweet;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        // String city = CacheHelper.getData(key: CacheConstants.city);
        // String county = CacheHelper.getData(key: CacheConstants.country);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: textEditingController,
              onChanged: (text) {
                cubit.onDescriptionChanged(
                  text,
                );
              },
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: isTweet
                      ? 'What\'s happening?'
                      : isRetweet
                          ? 'Add a comment'
                          : 'Tweet your reply',
                  hintStyle: TextStyle(fontSize: 18.sp)),
            ),
            if (cubit.isHandleLocationPermission! && cubit.city != null)
              Row(children: [
                Icon(Icons.location_on,
                    size: 18, color: AppColor.darkGrey.withOpacity(0.5)),
                Text('${cubit.city} , ${cubit.country} ',
                    style: TextStyles.font14GrayRegular),
              ]),
          ],
        );
      },
    );
  }
}

/*class _UserList extends StatelessWidget {
  const _UserList({Key? key, this.list, required this.textEditingController})
      : super(key: key);
  final List<UserModel>? list;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = HomeCubit.get(context);

        return cubit.displayUserList ||
                list == null ||
                list!.length < 0 ||
                list!.isEmpty
            ? const SizedBox.shrink()
            : Container(
                padding: const EdgeInsetsDirectional.only(bottom: 50),
                color: ColorsManager.white,
                constraints: const BoxConstraints(
                    minHeight: 30, maxHeight: double.infinity),
                child: ListView.builder(
                  itemCount: list!.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _UserTile(
                      user: list![index],
                      onUserSelected: (user) {
                        textEditingController.text =
                            "${cubit.getDescription(user.userName!)}  ";
                        textEditingController.selection =
                            TextSelection.collapsed(
                                offset: textEditingController.text.length);
                        cubit.onUserSelected();
                      },
                    );
                  },
                ),
              );
      },
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({Key? key, required this.user, required this.onUserSelected})
      : super(key: key);
  final UserModel user;
  final ValueChanged<UserModel> onUserSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onUserSelected(user);
      },
      leading: CustomImageCircle(path: user.profilePic, height: 35),
      title: Row(
        children: <Widget>[
          ConstrainedBox(
            constraints:
                BoxConstraints(minWidth: 0, maxWidth: context.width * .5),
            child: Text(
              user.displayName!,
              style: TextStyles.font16BlackExtraBold
                  .copyWith(overflow: TextOverflow.ellipsis),
            ),
          ),
          const SizedBox(width: 3),
          user.isVerified!
              ? const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    AppIcon.blueTick,
                    color: AppColor.primary,
                    size: 13,
                  ),
                )
              : const SizedBox(width: 0),
        ],
      ),
      subtitle: Text(user.userName!),
    );
  }
}*/
