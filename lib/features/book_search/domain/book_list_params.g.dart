// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookListParams _$BookListParamsFromJson(Map<String, dynamic> json) =>
    BookListParams(
      query: json['query'] as String? ?? 'ㄱ',
      display: json['display'] as int? ?? 20,
      start: json['start'] as int? ?? 1,
    );

Map<String, dynamic> _$BookListParamsToJson(BookListParams instance) =>
    <String, dynamic>{
      'query': instance.query,
      'display': instance.display,
      'start': instance.start,
    };
