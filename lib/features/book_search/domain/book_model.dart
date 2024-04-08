import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class BookModel {
  final String title;
  final String link;
  final String image;
  final String author;
  final String discount;
  final String pubdate;
  final String isbn;
  final String description;

  const BookModel({
    required this.title,
    required this.link,
    required this.image,
    required this.author,
    required this.discount,
    required this.pubdate,
    required this.isbn,
    required this.description,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}
