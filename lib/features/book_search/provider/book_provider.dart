import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxaac_app/features/book_search/domain/book_list_params.dart';
import 'package:foxaac_app/features/book_search/domain/book_pagination_model.dart';
import 'package:foxaac_app/features/book_search/provider/book_repository_provider.dart';
import 'package:foxaac_app/shared/utils/logger.dart';

final bookNotifierProvider =
    StateNotifierProvider.family<BookNotifierProvider, AsyncValue<BookPaginationModel>, String>((ref, query) {
  final bookRepository = ref.watch(bookRepositoryProvider);
  // final query =
  final notifier = BookNotifierProvider(bookRepository: bookRepository, query: query);

  return notifier;
});

class BookNotifierProvider extends StateNotifier<AsyncValue<BookPaginationModel>> {
  final BookRepository bookRepository;
  final String query;

  BookNotifierProvider({
    required this.bookRepository,
    required this.query,
  }) : super(const AsyncValue.loading()) {
    // get();
    get();
  }

  Future<void> get() async {
    try {
      state = const AsyncValue.loading();
      logger.d('state: $state');

      BookListParams bookListParams = BookListParams(query: query);
      final result = await bookRepository.getBookList(bookListParams: bookListParams);

      state = AsyncValue.data(result);
      logger.d('state: $state');
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      logger.d(e);
    }
  }
}
