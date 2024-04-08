import 'package:foxaac_app/features/book_search/domain/book_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_pagination_model.g.dart';

@JsonSerializable()
class BookPaginationModel {
  final String lastBuildDate;
  final int total;
  final int start;
  final int display;
  final List<BookModel> items;

  BookPaginationModel({
    required this.lastBuildDate,
    required this.total,
    required this.start,
    required this.display,
    required this.items,
  });

  factory BookPaginationModel.fromJson(Map<String, dynamic> json) => _$BookPaginationModelFromJson(json);
}
