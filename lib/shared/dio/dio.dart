import 'package:dio/dio.dart';
import 'package:foxaac_app/shared/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio();
  dio.interceptors.add(CustomInterceptor());
  dio.options = BaseOptions(
      // 디폴트 옵션
      );
  return dio;
}

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.d(options.baseUrl);
    logger.d(options.queryParameters);
    logger.d(options.data);
    logger.d(options.headers);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(err);
    super.onError(err, handler);
  }
}
