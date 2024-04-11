import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxaac_app/features/book_search/domain/book_list_params.dart';
import 'package:foxaac_app/features/book_search/domain/book_pagination_model.dart';
import 'package:foxaac_app/features/book_search/provider/book_repository_provider.dart';
import 'package:foxaac_app/shared/utils/logger.dart';

final bookNotifierProvider =
    StateNotifierProvider<BookNotifierProvider, BookPaginationModel>((ref) {
  final bookRepository = ref.watch(bookRepositoryProvider);
  final notifier = BookNotifierProvider(
    bookRepository: bookRepository,
    // params: params,
  );

  return notifier;
});

class BookNotifierProvider extends StateNotifier<BookPaginationModel> {
  final BookRepository bookRepository;
  // final BookListParams params;

  BookNotifierProvider({
    required this.bookRepository,
  }) : super(BookPaginationModel.initial());

  Future<void> get({
    required BookListParams params,
  }) async {
    try {
      final res = await bookRepository.getBookList(bookListParams: params);

      if (state.start == 1) {
        logger.d('검색');
        state = res.copyWith(
          state: BookPaginationModelState.data,
        );
      } else if (state.state == BookPaginationModelState.data &&
          ((state.total - state.start - state.display) > 0)) {
        logger.d('데이터가 이미 있을 때');
        state = res.copyWith(
          state: BookPaginationModelState.data,
          items: [...state.items, ...res.items],
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
}
