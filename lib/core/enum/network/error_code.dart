import 'package:json_annotation/json_annotation.dart';

enum EErrorCode {
  @JsonValue(-1)
  unauthenticated,

  @JsonValue(0)
  unknown,

  @JsonValue(1)
  ok,


}

const errorCodeEnumMap = {
  EErrorCode.unauthenticated: -1,
  EErrorCode.unknown: 0,
  EErrorCode.ok: 1,
};
