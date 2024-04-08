// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookPaginationModel _$BookPaginationModelFromJson(Map<String, dynamic> json) =>
    BookPaginationModel(
      lastBuildDate: json['lastBuildDate'] as String,
      total: json['total'] as int,
      start: json['start'] as int,
      display: json['display'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookPaginationModelToJson(
        BookPaginationModel instance) =>
    <String, dynamic>{
      'lastBuildDate': instance.lastBuildDate,
      'total': instance.total,
      'start': instance.start,
      'display': instance.display,
      'items': instance.items,
    };
