import 'package:foxaac_app/features/book_search/domain/book_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_pagination_model.g.dart';

enum BookPaginationModelState {
  initial,
  loading,
  error,
  data,
  // fetchingMore,
  // fetchedAllProducts
}

@JsonSerializable()
class BookPaginationModel {
  final String lastBuildDate;
  final int total;
  final int start;
  final int display;
  final List<BookModel> items;
  final BookPaginationModelState state;

  BookPaginationModel({
    required this.lastBuildDate,
    required this.total,
    required this.start,
    required this.display,
    required this.items,
    this.state = BookPaginationModelState.data,
  });

  BookPaginationModel.initial({
    this.lastBuildDate = "",
    this.total = 0,
    this.start = 0,
    this.display = 0,
    this.items = const [
      BookModel(
        title: '',
        link: '',
        image: '',
        author: '',
        discount: '',
        pubdate: '',
        isbn: '',
        description: '',
      ),
    ],
    this.state = BookPaginationModelState.initial,
  });

  BookPaginationModel copyWith({
    String? lastBuildDate,
    int? total,
    int? start,
    int? display,
    List<BookModel>? items,
    BookPaginationModelState? state,
  }) {
    return BookPaginationModel(
      lastBuildDate: this.lastBuildDate,
      total: this.total,
      start: this.start,
      display: this.display,
      items: this.items,
      state: this.state,
    );
  }

  factory BookPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$BookPaginationModelFromJson(json);
}
