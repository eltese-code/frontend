import 'package:dio/dio.dart';
import 'package:foxaac_app/configs/app_configs.dart';
import 'package:foxaac_app/env/env.dart';
import 'package:foxaac_app/features/book_search/domain/book_list_params.dart';
import 'package:foxaac_app/features/book_search/domain/book_pagination_model.dart';

abstract class BookSearchDataSource {
  Future<BookPaginationModel> getBookList({
    required BookListParams bookListParams,
  });
}

// retrofit 헤더에 Env 변수가 제대로 들어가지 않아서 dio로 작성
class BookSearchRemoteDataSource extends BookSearchDataSource {
  final Dio dio;

  BookSearchRemoteDataSource(this.dio);

  final baseUrl = AppConfigs.naverApiBaseUrl;

  @override
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
