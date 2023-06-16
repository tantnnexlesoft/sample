import 'package:json_annotation/json_annotation.dart';

enum ELogLevel {
  @JsonValue(0)
  basic,

  @JsonValue(1)
  medium,

  @JsonValue(2)
  detail,
}
