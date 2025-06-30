import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/services/binance_websocket_service.dart';
import 'package:trading_sample_app/app/services/order_service.dart';

class RootViewmodel extends IndexTrackingViewModel {
  final OrderService _orderService = locator<OrderService>();
  final BiWebSocketService _webSocketService = locator<BiWebSocketService>();

  RootViewmodel(int initialIndex) {
    setIndex(initialIndex);
  }

  void initData() {
    _webSocketService.getAllSymbols();
  }

  void onClickBottomBar(int index) async {
    initData();
    setIndex(index);
    if (index == 1) {
      await _orderService.refreshOrders();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _webSocketService.disconnectAllSymbolChannel();
    super.dispose();
  }
}
