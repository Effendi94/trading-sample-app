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

  Future<double> coinBalance(String symbol) async {
    final box = _hive.orderBox;
    final relevantOrders = box.values.where((o) => o.symbol == symbol);

    double total = 0.0;
    for (var order in relevantOrders) {
      total += (order.type == OrderType.buy ? order.amount : -order.amount);
    }

    return total;
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
