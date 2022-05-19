import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@immutable
@freezed
abstract class User with _$User {
  const User._();
  const factory User({
    required String name,
    required String avatarUrl,
  }) = _User;
}
