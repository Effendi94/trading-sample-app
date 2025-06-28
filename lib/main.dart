import 'package:flutter/material.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/services/hive_service.dart';
import 'package:trading_sample_app/app/services/profile_service.dart';
import 'package:trading_sample_app/app/trading_simple_app.dart';
import 'package:trading_sample_app/ui/shared/setup_snackbar_ui.dart';

Future<void> main() async {
  // F.appFlavor = Flavor.DEV;
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  // setupBottomSheetUI();
  setupSnackbarUI();
  // setupDialogUI();

  final hiveService = locator<HiveService>();
  await hiveService.init();
  final profileService = locator<ProfileService>();
  await profileService.init();

  runApp(const TradingSimpleApp());
}
