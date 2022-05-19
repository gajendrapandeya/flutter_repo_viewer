import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_response.freezed.dart';

@freezed
abstract class RemoteResponse<T> with _$RemoteResponse {
  const RemoteResponse._();
  const factory RemoteResponse.noConnection() = _NoConnection<T>;
  const factory RemoteResponse.notModified() = _NotModified<T>;
  const factory RemoteResponse.withNewData(T data) = _WithNewData<T>;
}
