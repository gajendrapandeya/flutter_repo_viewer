import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_response.freezed.dart';

@freezed
abstract class RemoteResponse<T> with _$RemoteResponse {
  const RemoteResponse._();
  const factory RemoteResponse.noConnection({required int maxPage}) =
      _NoConnection<T>;
  const factory RemoteResponse.notModified({required int maxPage}) =
      _NotModified<T>;
  const factory RemoteResponse.withNewData(T data, {required int maxPage}) =
      _WithNewData<T>;
}
