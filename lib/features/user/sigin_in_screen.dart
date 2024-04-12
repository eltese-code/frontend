import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxaac_app/env/env.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    KakaoSdk.init(nativeAppKey: Env.kakaoNativeAppKey);

    Future<void> token() async {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();

      print('token');
      print(token);
    }

    Future<void> user() async {
      User user = await UserApi.instance.me();

      print('user');
      print(user.kakaoAccount);
    }

    Future<void> signInWithKakao() async {
      // 카카오 로그인 구현 예제

      // 카카오톡 실행 가능 여부 확인
      // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
      if (await isKakaoTalkInstalled()) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          print('1. 카카오톡으로 로그인 성공');

          await token();
          await user();
        } catch (error) {
          print('카카오톡으로 로그인 실패 $error');

          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
          if (error is PlatformException && error.code == 'CANCELED') {
            return;
          }
          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
          try {
            await UserApi.instance.loginWithKakaoAccount();
            print('2. 카카오계정으로 로그인 성공');

            await token();
            await user();
          } catch (error) {
            print('카카오계정으로 로그인 실패 $error');
          }
        }
      } else {
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('3. 카카오계정으로 로그인 성공');

          print('token: $token');

          User user = await UserApi.instance.me();

          print(user.id);
          print(user.kakaoAccount);
          print(user.properties);

          // OAuthToken token =  await UserApi.instance.loginWithKakaoTalk();

          // await token();
          // await user();
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }

      // await token();
    }

    // void

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 11, 0, 30),
              Color.fromARGB(255, 35, 29, 92),
            ],
            stops: [0, 1],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
            const Text(
              '폭삭',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                //
                await signInWithKakao();
                // await token();
                // await user();
              },
              child: const Text('kakao로 시작하기'),
            ),
          ],
        ),
      ),
    );
  }
}
