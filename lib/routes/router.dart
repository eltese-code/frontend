import 'package:flutter/cupertino.dart';
import 'package:foxaac_app/features/book_detail/presentation/book_detail_screen.dart';
import 'package:foxaac_app/features/book_search/domain/book_model.dart';
import 'package:foxaac_app/features/feed/test_feed_screen_light.dart';
import 'package:foxaac_app/features/home/ladder_screen.dart';
import 'package:foxaac_app/features/mypage/mypage_screen.dart';
import 'package:foxaac_app/features/presentation/book_list_screen.dart';
import 'package:foxaac_app/features/user/sigin_in_screen.dart';
import 'package:foxaac_app/ui/app_scaffold.dart';
import 'package:go_router/go_router.dart';

class ScreenPaths {
  static String signIn = '/signIn';
  static String home = '/home';
  static String feed = '/feed';
  static String mypage = '/mypage';
  static String bookList = 'bookList';
  static String bookDetail = 'bookDetail';
}

final appRouter = GoRouter(
  initialLocation: ScreenPaths.signIn,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, router, navigator) {
        return FoxaacAppScaffold(child: navigator);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: ScreenPaths.home,
                builder: (context, state) => const LadderScreen(),
                routes: [
                  GoRoute(
                    path: ScreenPaths.bookList,
                    name: 'bookList',
                    routes: [
                      GoRoute(
                        path: ScreenPaths.bookDetail,
                        name: 'bookDetail',
                        pageBuilder: (context, state) {
                          final book = state.extra as BookModel;

                          return CustomTransitionPage(
                            key: state.pageKey,
                            child: BookDetailScreen(book: book),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            },
                          );
                        },
                      ),
                    ],
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const BookListScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  ),
                ]),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: ScreenPaths.feed,
              builder: (context, state) => const TestFeedScreenLight(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: ScreenPaths.mypage,
              builder: (context, state) => const MyPageScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: ScreenPaths.signIn,
      name: 'signIn',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SignInScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),

    // GoRoute(
    //   path: ScreenPaths.bookDetail,
    //   name: '/bookDetail',
    //   pageBuilder: (context, state) {
    //     final book = state.extra as BookModel;

    //     return CustomTransitionPage(
    //       key: state.pageKey,
    //       child: BookDetailScreen(book: book),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(opacity: animation, child: child);
    //       },
    //     );
    //   },
    // ),
  ],
);

class AppRoute extends GoRoute {
  AppRoute(
    String path,
    Widget widget, {
    List<GoRoute> routes = const [],
    this.useFade = false,
  }) : super(
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            // final pageContent = widget;
            // Scaffold(
            //   body: widget,
            //   resizeToAvoidBottomInset: false,
            // );
            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: widget,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: widget);
          },
        );
  final bool useFade;
}
