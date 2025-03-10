import 'package:json_annotation/json_annotation.dart';

part 'exception_response.g.dart';

@JsonSerializable()
class ExceptionResponse {
  final int errorCode;
  final String message;

  ExceptionResponse({
    required this.errorCode,
    required this.message,
  });

  factory ExceptionResponse.fromJson(Map<String, dynamic> json) =>
      _$ExceptionResponseFromJson(json);
}
