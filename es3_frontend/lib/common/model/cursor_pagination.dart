import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination.g.dart';

abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({required this.message});
}

class CursorPaginationLoading extends CursorPaginationBase {}

@JsonSerializable(genericArgumentFactories: true)
class CursorPagination<T> extends CursorPaginationBase {
  final int? nextCursor;
  final bool hasNext;
  final List<T> content;

  CursorPagination({
    required this.nextCursor,
    required this.hasNext,
    required this.content,
  });

  CursorPagination copyWith({int? nextCursor, bool? hasNext, List<T>? content}) {
    return CursorPagination<T>(
      nextCursor: nextCursor ?? this.nextCursor,
      hasNext: hasNext ?? this.hasNext,
      content: content ?? this.content,
    );
  }

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

//다시 처음부터 불러오기 (새로고침)
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.nextCursor,
    required super.hasNext,
    required super.content,
  });
}

//리스트의 맨 아래로 내려서 추가 데이터를 요청하는중
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.nextCursor,
    required super.hasNext,
    required super.content,
  });
}
