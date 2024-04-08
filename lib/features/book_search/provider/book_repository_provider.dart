import 'package:dio/dio.dart' hide Headers;
import 'package:foxaac_app/configs/app_configs.dart';
import 'package:foxaac_app/env/env.dart';
import 'package:foxaac_app/features/book_search/domain/book_list_params.dart';
import 'package:foxaac_app/features/book_search/domain/book_pagination_model.dart';
import 'package:foxaac_app/shared/dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_repository_provider.g.dart';

final bookRepositoryProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  final repository = BookRepository(dio, baseUrl: AppConfigs.naverApiBaseUrl);

  return repository;
});

@RestApi()
abstract class BookRepository {
  factory BookRepository(Dio dio, {String baseUrl}) = _BookRepository;

  @GET('')
  @Headers({
    'X-Naver-Client-Id': Env.clientId,
    'X-Naver-Client-Secret': Env.clientSecret,
  })
  Future<BookPaginationModel> getBookList({
    @Queries() required BookListParams bookListParams,
  });
}
