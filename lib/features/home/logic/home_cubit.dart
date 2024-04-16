import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:x/features/chat/ui/chat_screen.dart';
import 'package:x/features/home/data/repository/home_repo.dart';

import '../../../core/helper/cache_helper.dart';
import '../../../core/utilits/utility.dart';
import '../../feed/ui/feed_screen.dart';
import '../../notification/ui/notification_screen.dart';
import '../../search/ui/search_screen.dart';
import '../../sign_up/data/models/user_model.dart';
import '../data/models/feedModel.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());

  final HomeRepo _homeRepo;

  static HomeCubit get(context) => BlocProvider.of(context);

  bool enableSubmitButton = false;

  bool _isScrollingDown = false;

  bool get isScrollingDown => _isScrollingDown;

  FeedModel? _tweetToReplyModel;

  FeedModel? get tweetToReplyModel => _tweetToReplyModel;

  set setTweetToReply(FeedModel model) {
    _tweetToReplyModel = model;
  }

  set setIsScrollingDown(bool value) {
    _isScrollingDown = value;
    emit(ScrollChanged());
  }

  List<Widget> bottomScreens(ScrollController scrollController) => [
        FeedScreen(scrollController),
        SearchScreen(scrollController),
        NotificationScreen(scrollController),
        ChatScreen(scrollController),
      ];

  int currentIndex = 0;

  void changeBottom(int index) {
    currentIndex = index;
    emit(BottomChanged());
  }

  UserModel? userModel;

  void emitProfileStates() async {
    emit(HomeLoading());
    final result = await _homeRepo.getProfile();
    result.when(success: (profile) {
      print(profile.profilePic);
      print('========================');
      userModel = profile;
      emit(HomeSuccess(profile));
    }, failure: (error) {
      emit(HomeError(error.message ?? 'Something went wrong'));
    });
  }

  List<UserModel> listUser = [];

  void emitGetProfileStates() async {
    emit(HomeLoading());
    final result = await _homeRepo.getAllUser();
    result.when(success: (user) {
      print(user[0].userName);
      print('========================');
      listUser = user;
      emit(HomeSuccessListUser(user));
    }, failure: (error) {
      emit(HomeError(error.message ?? 'Something went wrong'));
    });
  }

  File? tweetImage;
  var picker = ImagePicker();

  void clearTweetImage() {
    tweetImage = null;
    emit(TweetImagePickedSuccessState());
  }

  Future<void> getPickedTweetImage(ImageSource source) async {
    PermissionStatus status;
    if (source == ImageSource.camera) {
      status = await Permission.camera.status;
    } else {
      status = await Permission.photos.status;
    }
    if (status.isGranted) {
      final pickedFile =
          await picker.pickImage(source: source, imageQuality: 20);

      if (pickedFile != null) {
        tweetImage = File(pickedFile.path);
        print('================================${pickedFile.path}');
        emit(TweetImagePickedSuccessState());
      } else {
        print('No image selected.');
        emit(TweetImagePickedErrorState());
      }
    } else if (status.isDenied) {
      if (source == ImageSource.camera) {
        status = await Permission.camera.status;
      } else {
        status = await Permission.photos.status;
      }
      if (status.isGranted) {
        getPickedTweetImage(source);
      } else {
        openAppSettings();
      }
    }
  }

  String? imageUrl;

  Future<String?> emitUploadImageStates(File? image) async {
    emit(HomeLoadingUploadImage());
    final result = await _homeRepo.uploadImage(image!);
    result.when(success: (url) {
      print(url);
      imageUrl = url;
      emit(HomeSuccessUploadImage(url));
      print('======================== $url');
      return url;
    }, failure: (error) {
      emit(HomeErrorUploadImage(error.message ?? 'Something went wrong'));
    });
    return null;
  }

  void emitCreateTweetStates(FeedModel model) async {
    emit(HomeLoadingCreateTweet());
    final result = await _homeRepo.createTweet(model);
    result.when(success: (id) {
      print('create Tweet $id');
      emit(HomeSuccessCreateTweet(id));
    }, failure: (error) {
      emit(HomeErrorCreateTweet(error.message ?? 'Something went wrong'));
    });
  }

  bool hideUserList = false;
  String description = "";

  void onDescriptionChanged(String text) {
    description = text;
    hideUserList = false;
    if (text.isEmpty || text.length > 280) {
      /// Disable submit button if description is not available
      enableSubmitButton = false;
      emit(HomeDescriptionChanged());
      if (kDebugMode) {
        print('enableSubmitButton = false');
      }
      return;
    }
    emit(HomeDescriptionChanged());
  }

  final usernameRegex = r'(@\w*[a-zA-Z1-9]$)';

  /// When user select user from user list it will add username in description

  String getDescription(String username) {
    RegExp regExp = RegExp(usernameRegex);
    Iterable<Match> _matches = regExp.allMatches(description);
    var name = description.substring(0, _matches.last.start);
    description = '$name $username';
    return description;
  }

  void onUserSelected() {
    hideUserList = true;
    emit(HomeDescriptionChanged());
  }

  /// Display/Hide user list on the basis of username availability in description
  /// To display user list in compose screen two condition is required
  /// First is value of `status` should be true
  /// Second value of  `hideUserList` should be false
  bool get displayUserList {
    RegExp regExp = RegExp(usernameRegex);
    var status = regExp.hasMatch(description);
    if (status && !hideUserList) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  late String? city;

  late String? country;

  bool? isHandleLocationPermission = false;

  Future<void> getUserCountryAndCity() async {
    if (await handleLocationPermission()) {
      emit(HomeLoadingLocation());
      isHandleLocationPermission = true;
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      await placemarkFromCoordinates(position.latitude, position.longitude)
          .then((List<Placemark> placeMarks) {
        Placemark place = placeMarks[0];
        print(
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}');
        CacheHelper.saveData(
            key: CacheConstants.city,
            value: place.subAdministrativeArea.toString());
        CacheHelper.saveData(
            key: CacheConstants.country, value: place.country.toString());
        city = place.subAdministrativeArea.toString();
        country = place.country.toString();
        emit(HomeSuccessLocation(place));
      }).catchError((e) {
        emit(HomeErrorLocation(e.toString()));
        debugPrint(e);
      });
    } else {
      isHandleLocationPermission = false;
      emit(HomeErrorLocation('Permission Denied'));
    }
  }
}
