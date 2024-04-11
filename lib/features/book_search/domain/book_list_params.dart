import 'package:json_annotation/json_annotation.dart';

part 'book_list_params.g.dart';

@JsonSerializable()
class BookListParams {
  final String? query;
  final int? display;
  final int? start;

  const BookListParams({
    this.query = 'ㄱ',
    this.display = 20,
    this.start = 1,
  });

  factory BookListParams.fromJson(Map<String, dynamic> json) =>
      _$BookListParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BookListParamsToJson(this);
}
