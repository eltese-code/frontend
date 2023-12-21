import 'package:flutter/material.dart';
import 'package:foxaac_app/logic/app_logic.dart';
import 'package:foxaac_app/routes/router.dart';
import 'package:foxaac_app/styles/styles.dart';
import 'package:foxaac_app/ui/app_scaffold.dart';
import 'package:get_it/get_it.dart';

void main() {
  // start app
  registerSingletons();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: appRouter.routeInformationProvider,
      routeInformationParser: appRouter.routeInformationParser,
      routerDelegate: appRouter.routerDelegate,
      theme: ThemeData(fontFamily: 'suit', useMaterial3: true),
    );
  }
}

void registerSingletons() {
  GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());
}

AppLogic get appLogic => GetIt.I.get<AppLogic>();
AppStyle get $styles => FoxaacAppScaffold.style;
