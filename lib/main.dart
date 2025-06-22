import 'package:flutter/material.dart';
import 'package:trading_sample_app/app/trading_simple_app.dart';

Future<void> main() async {
  // F.appFlavor = Flavor.DEV;

  WidgetsFlutterBinding.ensureInitialized();

  // await SharedPrefs().init();
  // setPathUrlStrategy();
  // setupLocator();
  // setupBottomSheetUI();
  // setupSnackbarUI();
  // setupDialogUI();

  runApp(const TradingSimpleApp());
}
