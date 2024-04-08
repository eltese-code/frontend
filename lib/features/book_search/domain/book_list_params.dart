import 'package:json_annotation/json_annotation.dart';

part 'book_list_params.g.dart';

@JsonSerializable()
class BookListParams {
  final String? query;

  const BookListParams({
    this.query = 'ㄱ',
  });

  factory BookListParams.fromJson(Map<String, dynamic> json) => _$BookListParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BookListParamsToJson(this);
}
