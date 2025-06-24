import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:trading_sample_app/app/app.router.dart';
import 'package:trading_sample_app/app/constants/common.dart';
import 'package:trading_sample_app/app/theme/app_theme_data.dart';

class TradingSimpleApp extends StatelessWidget {
  const TradingSimpleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Common.titleBar,
      theme: appThemeData(context),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      supportedLocales: const [Locale('id'), Locale('en')],
    );
  }
}
