import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/services/binance_websocket_service.dart';

class OrderViewmodel extends ReactiveViewModel {
  final BiWebSocketService _webSocketService = locator<BiWebSocketService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_webSocketService];
}
