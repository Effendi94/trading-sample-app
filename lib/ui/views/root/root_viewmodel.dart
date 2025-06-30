import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/services/order_service.dart';

class RootViewmodel extends IndexTrackingViewModel {
  final OrderService _orderService = locator<OrderService>();

  RootViewmodel(int initialIndex) {
    setIndex(initialIndex);
  }

  void onClickBottomBar(int index) async {
    setIndex(index);
    if (index == 1) {
      await _orderService.refreshOrders();
      notifyListeners();
    }
  }
}
