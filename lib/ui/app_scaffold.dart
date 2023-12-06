import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foxaac_app/assets.dart';
import 'package:foxaac_app/main.dart';
import 'package:foxaac_app/styles/styles.dart';
import 'package:go_router/go_router.dart';

class FoxaacAppScaffold extends StatelessWidget {
  const FoxaacAppScaffold({super.key, required this.child});

  final StatefulNavigationShell child;
  static AppStyle get style => _style;
  static final AppStyle _style = AppStyle();

  void _goBranch(int index) {
    child.goBranch(
      index,
      initialLocation: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    appLogic.handleAppSizeChanged(mq.size);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12.0,
        showUnselectedLabels: false,
        currentIndex: child.currentIndex,
        onTap: _goBranch,
        items: [
          _item('서재', FilePaths.bottomBarFillCat, 0, child, style),
          _item('친구 탐라', FilePaths.bottomBarFillFeed, 1, child, style),
          _item('마이 페이지', FilePaths.bottomBarFillUser, 2, child, style),
        ],
      ),
    );
  }
}

BottomNavigationBarItem _item(
  String label,
  String iconPath,
  int index,
  StatefulNavigationShell child,
  AppStyle style,
) {
  return BottomNavigationBarItem(
    label: label,
    icon: SvgPicture.asset(
      iconPath,
      colorFilter: ColorFilter.mode(
        child.currentIndex == index
            ? style.colors.primaryColor
            : style.colors.grey,
        BlendMode.srcIn,
      ),
    ),
  );
}
