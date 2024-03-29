import 'package:freezed_annotation/freezed_annotation.dart';

part 'fresh.freezed.dart';

@immutable
@freezed
abstract class Fresh<T> with _$Fresh<T> {
  const Fresh._();
  const factory Fresh({
    required T entity,
    required bool isFresh,
    bool? isNextPageAvailable,
  }) = _Fresh<T>;

  factory Fresh.yes(T entity, {bool? isNextPageAvailable}) => Fresh(
        entity: entity,
        isFresh: true,
        isNextPageAvailable: isNextPageAvailable,
      );

  factory Fresh.no(T entity, {bool? isNextPageAvailable}) => Fresh(
        entity: entity,
        isFresh: false,
        isNextPageAvailable: isNextPageAvailable,
      );
}
