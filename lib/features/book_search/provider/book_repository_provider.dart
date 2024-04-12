import 'package:dio/dio.dart' hide Headers;
import 'package:foxaac_app/configs/app_configs.dart';
import 'package:foxaac_app/env/env.dart';
import 'package:foxaac_app/features/book_search/domain/book_list_params.dart';
import 'package:foxaac_app/features/book_search/domain/book_pagination_model.dart';
import 'package:foxaac_app/shared/dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final bookRepositoryProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  final repository = BookRepository(dio, baseUrl: AppConfigs.naverApiBaseUrl);

  return repository;
});

// retrofit 헤더에 Env 변수가 제대로 들어가지 않아서 dio로 작성
class BookRepository {
  final Dio dio;
  final String baseUrl;

  BookRepository(this.dio, {required this.baseUrl});

  Future<BookPaginationModel> getBookList({
    required BookListParams bookListParams,
  }) async {
    final res = await dio.get(
      baseUrl,
      options: Options(
        headers: {
          'X-Naver-Client-Id': Env.clientId,
          'X-Naver-Client-Secret': Env.clientSecret,
        },
      ),
      queryParameters: bookListParams.toJson(),
    );

    final result = BookPaginationModel.fromJson(res.data);

    return result;
  }
}
