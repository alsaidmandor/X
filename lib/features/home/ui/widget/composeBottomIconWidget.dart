import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theming/app_icons.dart';
import '../../../../core/theming/colors.dart';
import '../../logic/home_cubit.dart';

class ComposeBottomIconWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(File) onImageIconSelected;

  const ComposeBottomIconWidget(
      {Key? key,
      required this.textEditingController,
      required this.onImageIconSelected})
      : super(key: key);

  @override
  _ComposeBottomIconWidgetState createState() =>
      _ComposeBottomIconWidgetState();
}

class _ComposeBottomIconWidgetState extends State<ComposeBottomIconWidget> {
  bool reachToWarning = false;
  bool reachToOver = false;
  late Color wordCountColor;
  String tweet = '';

  @override
  void initState() {
    wordCountColor = Colors.blue;
    widget.textEditingController.addListener(updateUI);
    super.initState();
  }

  void updateUI() {
    setState(() {
      tweet = widget.textEditingController.text;
      if (widget.textEditingController.text.isNotEmpty) {
        if (widget.textEditingController.text.length > 259 &&
            widget.textEditingController.text.length < 280) {
          wordCountColor = Colors.orange;
        } else if (widget.textEditingController.text.length >= 280) {
          wordCountColor = Theme.of(context).colorScheme.error;
        } else {
          wordCountColor = Colors.blue;
        }
      }
    });
  }

  Widget _bottomIconWidget(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Theme.of(context).dividerColor)),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    cubit.getPickedTweetImage(ImageSource.gallery);
                    // setImage(ImageSource.gallery);
                  },
                  icon: const Icon(AppIcon.image, color: AppColor.primary)),
              IconButton(
                  onPressed: () {
                    cubit.getPickedTweetImage(ImageSource.camera);
                  },
                  icon: const Icon(AppIcon.camera, color: AppColor.primary)),
              IconButton(
                  onPressed: () {
                    cubit.getUserCountryAndCity();
                  },
                  icon:
                      const Icon(AppIcon.locationPin, color: AppColor.primary)),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: /*tweet != null &&*/ tweet.length > 289
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              '${280 - tweet.length}',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error),
                            ),
                          )
                        : Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(
                                value: getTweetLimit(),
                                backgroundColor: Colors.grey,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    wordCountColor),
                              ),
                              tweet.length > 259
                                  ? Text('${280 - tweet.length}',
                                      style: TextStyle(color: wordCountColor))
                                  : Text('',
                                      style: TextStyle(color: wordCountColor))
                            ],
                          )),
              ))
            ],
          ),
        );
      },
    );
  }

  Future<void> setImage(ImageSource source) async {
    ImagePicker()
        .pickImage(source: source, imageQuality: 20)
        .then((XFile? file) {
      setState(() {
        // _image = file;
        widget.onImageIconSelected(File(file!.path));
      });
    });
  }

  double getTweetLimit() {
    if (tweet.isEmpty) {
      return 0.0;
    }
    if (tweet.length > 280) {
      return 1.0;
    }
    var length = tweet.length;
    var val = length * 100 / 28000.0;
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _bottomIconWidget(context),
    );
  }
}
