import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  final int? cursor;
  final int? size;

  const PaginationParams({
    this.cursor,
    this.size,
  });

  PaginationParams copyWith({
    int? cursor,
    int? size,
  }) {
    return PaginationParams(
      cursor: cursor ?? this.cursor,
      size: size ?? this.size,
    );
  }

  factory PaginationParams.fromJson(Map<String, dynamic> json) => _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
