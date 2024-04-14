import 'package:foxaac_app/features/book_search/data/data_sources/book_search_data_source.dart';
import 'package:foxaac_app/features/book_search/domain/book_list_params.dart';
import 'package:foxaac_app/features/book_search/domain/book_pagination_model.dart';
import 'package:foxaac_app/features/book_search/domain/repositories/book_search_repository.dart';

class BookSearchRepositoryImpl extends BookSearchRepository {
  final BookSearchDataSource dataSource;

  BookSearchRepositoryImpl({required this.dataSource});

  @override
  Future<BookPaginationModel> getBookList({
    required BookListParams bookListParams,
  }) {
    return dataSource.getBookList(bookListParams: bookListParams);
  }
}
