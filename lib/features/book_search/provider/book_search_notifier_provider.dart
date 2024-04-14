import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxaac_app/features/book_search/domain/book_list_params.dart';
import 'package:foxaac_app/features/book_search/domain/book_pagination_model.dart';
import 'package:foxaac_app/features/book_search/domain/providers/book_search_provider.dart';
import 'package:foxaac_app/features/book_search/domain/repositories/book_search_repository.dart';
import 'package:foxaac_app/shared/utils/logger.dart';

final bookNotifierProvider =
    StateNotifierProvider<BookNotifierProvider, BookPaginationModel>((ref) {
  final bookSearchRepository = ref.watch(bookSearchRepositoryProvider);

  final notifier = BookNotifierProvider(
    bookSearchRepository: bookSearchRepository,
  );

  return notifier;
});

class BookNotifierProvider extends StateNotifier<BookPaginationModel> {
  final BookSearchRepository bookSearchRepository;

  BookNotifierProvider({
    required this.bookSearchRepository,
  }) : super(BookPaginationModel.initial());

  Future<void> get({
    required BookListParams params,
  }) async {
    try {
      if (state.state == BookPaginationModelState.data) return;

      final res =
          await bookSearchRepository.getBookList(bookListParams: params);

      if (state.start == 1) {
        logger.d('검색');
        state = res.copyWith(
          state: BookPaginationModelState.data,
        );
      } else {
        logger.d('아예 처음');
        state = res.copyWith(
          state: BookPaginationModelState.data,
        );
      }
    } catch (e) {
      state = state.copyWith(
        state: BookPaginationModelState.error,
      );
      logger.d(e);
    }
  }

  Future<void> fetchMore({
    required String query,
  }) async {
    final int start = state.start + state.display;
    final int total = state.total;

    if (start > total) return;

    final BookListParams params = BookListParams(
      query: query,
      start: start,
    );

    final res = await bookSearchRepository.getBookList(bookListParams: params);

    state = res.copyWith(
      state: BookPaginationModelState.data,
      items: [...state.items, ...res.items],
    );
  }
}
