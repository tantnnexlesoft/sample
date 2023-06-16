// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_log_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorLogRequest _$ErrorLogRequestFromJson(Map<String, dynamic> json) =>
    ErrorLogRequest(
      content: json['content'] as String,
      clientErrorType: json['clientErrorType'] as int,
    );

Map<String, dynamic> _$ErrorLogRequestToJson(ErrorLogRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'clientErrorType': instance.clientErrorType,
    };
