import 'package:flutter/cupertino.dart';
import 'package:foxaac_app/features/presentation/book_list_screen.dart';
import 'package:foxaac_app/ui/app_scaffold.dart';
import 'package:foxaac_app/ui/screens/feed/test_feed_screen_light.dart';
import 'package:foxaac_app/ui/screens/home/ladder_screen.dart';
import 'package:foxaac_app/ui/screens/mypage/mypage_screen.dart';
import 'package:go_router/go_router.dart';

class ScreenPaths {
  static String home = '/home';
  static String feed = '/feed';
  static String mypage = '/mypage';
  static String bookList = '/bookList';
}

final appRouter = GoRouter(
  initialLocation: ScreenPaths.home,
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
            ),
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
      path: ScreenPaths.bookList,
      name: '/bookList',
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const BookListScreen(),
        fullscreenDialog: true,
      ),
    ),
  ],
);
