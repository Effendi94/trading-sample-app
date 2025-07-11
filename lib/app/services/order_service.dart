import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/constants/common.dart';
import 'package:trading_sample_app/app/models/asset_model.dart';
import 'package:trading_sample_app/app/models/order_model.dart';
import 'package:trading_sample_app/app/services/hive_service.dart';

class OrderService with ListenableServiceMixin {
  final _hive = locator<HiveService>();
  final _orders = ReactiveValue<List<OrderModel>>([]);

  List<OrderModel> get orders => enrichedOrders;

  OrderService() {
    listenToReactiveValues([_orders]);
    getOrders();
    // _orders.value = _hive.orderBox.values.toList().reversed.toList();
    // _orders.value = enrichedOrders;
  }

  List<OrderModel> get enrichedOrders {
    return _orders.value.map((order) {
      final matchedAsset = Common.listAssets.firstWhere(
        (asset) => asset.symbol?.toLowerCase() == order.symbol.toLowerCase(),
        orElse:
            () => AssetModel(
              name: order.symbol,
              base: order.symbol.substring(0, 3),
              symbol: order.symbol,
              logoAsset: '',
            ),
      );

      return order.copyWith(asset: matchedAsset);
    }).toList();
  }

  Future<void> getOrders() async {
    _orders.value = _hive.orderBox.values.toList().reversed.toList();
    notifyListeners();
  }

  Future<void> refreshOrders() async {
    await getOrders();
  }

  Future<double> coinBalance(String symbol) async {
    final box = _hive.orderBox;
    final relevantOrders = box.values.where((o) => o.symbol.toLowerCase() == symbol.toLowerCase());

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
