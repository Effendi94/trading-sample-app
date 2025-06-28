import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:trading_sample_app/app/services/binance_websocket_service.dart';
import 'package:trading_sample_app/app/services/hive_service.dart';
import 'package:trading_sample_app/app/services/order_service.dart';
import 'package:trading_sample_app/app/services/profile_service.dart';
import 'package:trading_sample_app/ui/views/market/market_view.dart';
import 'package:trading_sample_app/ui/views/order/order_view.dart';
import 'package:trading_sample_app/ui/views/portfolio/portfolio_view.dart';
import 'package:trading_sample_app/ui/views/root/root_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: RootView, initial: true),
    MaterialRoute(page: OrderView, path: 'orderView'),
    MaterialRoute(page: MarketView, path: 'marketView'),
    MaterialRoute(page: PortfolioView, path: 'PortfolioView'),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    // LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BiWebSocketService),
    LazySingleton(classType: HiveService),
    LazySingleton(classType: OrderService),
    LazySingleton(classType: ProfileService),
  ],
)
class App {}
