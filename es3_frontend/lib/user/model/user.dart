import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

abstract class UserModelBase {}

class UserModelError extends UserModelBase {
  final String message;

  UserModelError({required this.message});
}

class UserModelLoading extends UserModelBase {}

@JsonSerializable()
class UserModel extends UserModelBase {
  final String email;
  final String name;
  final String mobile;

  UserModel({
    required this.email,
    required this.name,
    required this.mobile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
