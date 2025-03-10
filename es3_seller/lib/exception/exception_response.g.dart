// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exception_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExceptionResponse _$ExceptionResponseFromJson(Map<String, dynamic> json) =>
    ExceptionResponse(
      errorCode: (json['errorCode'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$ExceptionResponseToJson(ExceptionResponse instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'message': instance.message,
    };
