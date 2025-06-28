import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:trading_sample_app/app/app.router.dart';
import 'package:trading_sample_app/app/models/asset_model.dart';
import 'package:trading_sample_app/app/services/binance_websocket_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../app/app.locator.dart';

class HomeViewmodel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final BiWebSocketService _webSocketService = locator<BiWebSocketService>();

  List<AssetModel> get listAssets => _webSocketService.listAssets;

  bool get isWebsocketLoading => _webSocketService.isLoading;
  WebSocketChannel? get channel => _webSocketService.allSymbolChannel;

  void initData() {
    _webSocketService.getAllSymbols();
  }

  void navigateToOrderView(AssetModel asset) {
    _navigationService.navigateTo(Routes.marketView, arguments: MarketViewArguments(asset: asset));
  }

  @override
  void dispose() {
    _webSocketService.disconnectAllSymbolChannel();
    super.dispose();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_webSocketService];
}
