import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/models/order_model.dart';
import 'package:trading_sample_app/app/services/hive_service.dart';

class OrderService with ListenableServiceMixin {
  final _hive = locator<HiveService>();
  final _orders = ReactiveValue<List<OrderModel>>([]);

  List<OrderModel> get orders => _orders.value;

  OrderService() {
    listenToReactiveValues([_orders]);
    _orders.value = _hive.orderBox.values.toList().reversed.toList();
  }

  Future<void> placeOrder(OrderModel order) async {
    await _hive.orderBox.add(order);
    _orders.value = _hive.orderBox.values.toList().reversed.toList();
    notifyListeners();
  }

  Future<void> clearOrders() async {
    await _hive.orderBox.clear();
    _orders.value = [];
    notifyListeners();
  }
}
