import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/trading_simple_app.dart';

Future<void> main() async {
  // F.appFlavor = Flavor.DEV;

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  setupLocator();
  // setupBottomSheetUI();
  // setupSnackbarUI();
  // setupDialogUI();

  runApp(const TradingSimpleApp());
}
