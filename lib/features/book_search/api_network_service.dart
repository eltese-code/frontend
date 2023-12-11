import 'package:dio/dio.dart';
import 'package:foxaac_app/configs/app_configs.dart';

class DioNetworkService {
  //
  final Dio dio;

  DioNetworkService(this.dio);
// }

  BaseOptions get dioBaseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      );
// @override
  String get baseUrl => AppConfigs.naverApiBaseUrl;

// @override
  Map<String, Object> get headers => {
        'accept': 'application/json',
        'content-type': 'application/json',
        'X-Naver-Client-Id': 'yFa5CioOMj3xHpvc2fq5',
        'X-Naver-Client-Secret': 'MNKG6eOK3U',
      };

  Future get(String endpoint, {Map<String, dynamic>? queryParameters}) {
    // endpoint =
    queryParameters = {'query': 'ㅏ'};

    final res = dio.get(baseUrl, queryParameters: queryParameters);
    // // handleException(
    // //   () =>
    //   dio.get(
    //     endpoint,
    //     queryParameters: queryParameters,
    //   ),
    //   endpoint: endpoint,
    // );
    return res;
  }
}
