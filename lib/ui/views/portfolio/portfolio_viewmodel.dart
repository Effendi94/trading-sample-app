import 'dart:developer';

import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/helper/format_helpers.dart';
import 'package:trading_sample_app/app/models/order_model.dart';
import 'package:trading_sample_app/app/models/portfolio_model.dart';
import 'package:trading_sample_app/app/services/order_service.dart';
import 'package:trading_sample_app/app/services/profile_service.dart';

class PortfolioViewmodel extends ReactiveViewModel {
  final OrderService _orderService = locator<OrderService>();
  final ProfileService _profileService = locator<ProfileService>();

  List<OrderModel> get listOrders => _orderService.orders;

  String get profileBalance => usdCurrency(_profileService.balance);

  List<PortfolioModel> get holdingOrders {
    final Map<String, PortfolioModel> map = {};
    late double updatedAmount = 0;
    for (var order in listOrders) {
      if (!map.containsKey(order.symbol)) {
        map[order.symbol] = PortfolioModel(
          name: order.asset?.name,
          base: order.asset?.base,
          amount: 0,
          logo: order.asset?.logoAsset ?? '',
        );
      }

      final current = map[order.symbol]!;

      if (order.type == OrderType.buy) {
        updatedAmount += order.amount;
      } else {
        updatedAmount -= order.amount;
      }
      // current.amount + (order.type == OrderType.buy ? order.amount : -order.amount);

      map[order.symbol] = current.copyWith(amount: updatedAmount);
    }

    return map.values.where((o) => o.amount! > 0).toList();
  }

  void initData() {
    // final jsonList = listOrders.map((e) => e.toJson()).toList();
    // final data = jsonEncode(jsonList);
    // log(data);
    // log('list orders : ${listOrders.toString()}');
    // log(jsonEncode(holdingOrders.map((e) => e.toJson()).toList()));
  }

  // Todo: get coin balance group by coin
}
