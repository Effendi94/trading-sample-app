import 'dart:convert';
import 'dart:developer';

import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/models/order_model.dart';
import 'package:trading_sample_app/app/services/order_service.dart';

class PortfolioViewmodel extends BaseViewModel {
  final OrderService _orderService = locator<OrderService>();

  List<OrderModel> get listOrders => _orderService.orders;

  void initData() {
    final jsonList = listOrders.map((e) => e.toJson()).toList();
    final data = jsonEncode(jsonList);
    log(data);
  }
}
