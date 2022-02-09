import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
abstract class AuthFailure with _$AuthFailure {
  const AuthFailure._();
  const factory AuthFailure.server([String? message]) = _Server;
  const factory AuthFailure.storage() = _Storage;
}
