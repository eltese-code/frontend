import 'package:json_annotation/json_annotation.dart';

part 'add_book_model.g.dart';

@JsonSerializable()
class AddBookModel {
  final String bookTitle;
  final String bookAuthor;
  @JsonKey(toJson: enumToString)
  final BookPreference bookPreference;
  final String bookComment;
  final String startDate;
  final String endDate;

  AddBookModel({
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookPreference,
    required this.bookComment,
    required this.startDate,
    required this.endDate,
  });

  AddBookModel copyWith({
    String? bookTitle,
    String? bookAuthor,
    BookPreference? bookPreference,
    String? bookComment,
    String? startDate,
    String? endDate,
  }) {
    return AddBookModel(
      bookTitle: bookTitle ?? this.bookTitle,
      bookAuthor: bookAuthor ?? this.bookAuthor,
      bookPreference: bookPreference ?? this.bookPreference,
      bookComment: bookComment ?? this.bookComment,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toJson() => _$AddBookModelToJson(this);

  factory AddBookModel.fromJson(Map<String, dynamic> json) =>
      _$AddBookModelFromJson(json);

  static String enumToString(BookPreference bookPreference) {
    return '$bookPreference';
  }
}

enum BookPreference {
  PREFER,
  DISLIKE,
  INITIAL,
}
