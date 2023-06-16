// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      codeResult: $enumDecode(_$EErrorCodeEnumMap, json['codeResult'],
          unknownValue: EErrorCode.unknown),
      errorMessage: json['errorMessage'] as String,
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'codeResult': _$EErrorCodeEnumMap[instance.codeResult]!,
      'errorMessage': instance.errorMessage,
    };

const _$EErrorCodeEnumMap = {
  EErrorCode.unauthenticated: -1,
  EErrorCode.unknown: 0,
  EErrorCode.ok: 1,
};
