import 'package:json_annotation/json_annotation.dart';

import 'serializable.dart';

part 'error_log_request.g.dart';

@JsonSerializable()
class ErrorLogRequest implements Serializable {
  String content;
  int clientErrorType;

  ErrorLogRequest({
    required this.content,
    required this.clientErrorType,
  });

  factory ErrorLogRequest.fromJson(Map<String, dynamic> json) =>
      _$ErrorLogRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ErrorLogRequestToJson(this);
}
