import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:trading_sample_app/app/services/binance_websocket_service.dart';
import 'package:trading_sample_app/ui/views/root/root_view.dart';

@StackedApp(
  routes: [MaterialRoute(page: RootView, initial: true)],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BiWebSocketService),
  ],
)
class App {}
