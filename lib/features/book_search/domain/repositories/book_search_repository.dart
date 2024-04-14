import 'package:foxaac_app/features/book_search/domain/book_list_params.dart';
import 'package:foxaac_app/features/book_search/domain/book_pagination_model.dart';

abstract class BookSearchRepository {
  Future<BookPaginationModel> getBookList({
    required BookListParams bookListParams,
  });
}
