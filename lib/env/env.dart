import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'X-Naver-Client-Id')
  static const String clientId = _Env.clientId;
  @EnviedField(varName: 'X-Naver-Client-Secret')
  static const String clientSecret = _Env.clientSecret;
}
