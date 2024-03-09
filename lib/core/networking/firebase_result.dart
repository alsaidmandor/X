import 'package:firebase_core/firebase_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_result.freezed.dart';

@Freezed()
abstract class FirebaseResult<T> with _$FirebaseResult<T> {
  const factory FirebaseResult.success(T data) = Success<T>;

  const factory FirebaseResult.failure(FirebaseException errorHandler) =
      Failure<T>;
}
