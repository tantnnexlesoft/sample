import 'package:json_annotation/json_annotation.dart';

import '../enum/network/error_code.dart';


part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  @JsonKey(unknownEnumValue: EErrorCode.unknown)
  EErrorCode codeResult;
  String errorMessage;

  ApiResponse(
      {required this.codeResult,
      required this.errorMessage,
     });

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
