import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryModel {
  final int id;
  final String name;
  final int? parentsId;

  CategoryModel({
    required this.id,
    required this.name,
    this.parentsId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
}