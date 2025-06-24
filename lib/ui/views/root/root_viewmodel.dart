import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/ui/views/market/market_view.dart';
import 'package:trading_sample_app/ui/views/order/order_view.dart';
import 'package:trading_sample_app/ui/views/portfolio/portfolio_view.dart';

class RootViewmodel extends IndexTrackingViewModel {
  Widget getTabBarView(int value) {
    switch (value) {
      case 0:
        return const MarketView();
      case 1:
        return const OrderView();
      case 2:
        return const PortfolioView();
      default:
        return const MarketView();
    }
  }
}
