import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/models/asset_model.dart';
import 'package:trading_sample_app/app/services/binance_websocket_service.dart';

import '../../../app/app.locator.dart';

class HomeViewmodel extends ReactiveViewModel {
  final BiWebSocketService _webSocketService = locator<BiWebSocketService>();

  List<AssetModel> get listAssets => _webSocketService.listAssets;

  bool get isWebsocketLoading => _webSocketService.isLoading;

  void initData() {
    _webSocketService.connect();
  }

  @override
  void dispose() {
    _webSocketService.disconnect();
    super.dispose();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_webSocketService];
}
