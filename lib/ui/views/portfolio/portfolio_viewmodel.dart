import 'dart:convert';
import 'dart:developer';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/app.router.dart';
import 'package:trading_sample_app/app/helper/format_helpers.dart';
import 'package:trading_sample_app/app/models/asset_model.dart';
import 'package:trading_sample_app/app/models/order_model.dart';
import 'package:trading_sample_app/app/models/portfolio_model.dart';
import 'package:trading_sample_app/app/services/binance_websocket_service.dart';
import 'package:trading_sample_app/app/services/order_service.dart';
import 'package:trading_sample_app/app/services/profile_service.dart';

class PortfolioViewmodel extends ReactiveViewModel {
  final OrderService _orderService = locator<OrderService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ProfileService _profileService = locator<ProfileService>();
  final BiWebSocketService _webSocketService = locator<BiWebSocketService>();

  List<OrderModel> get listOrders => _orderService.orders;
  List<AssetModel> get listAssets => _webSocketService.listAssets;
  String get profileBalance => usdCurrency(_profileService.balance);

  List<PortfolioModel> get holdingOrders {
    final Map<String, double> amountMap = {};
    final Map<String, AssetModel?> assetMap = {};

    for (var order in listOrders) {
      final symbol = order.symbol;

      // Initialize values if not present
      amountMap[symbol] =
          (amountMap[symbol] ?? 0) + (order.type == OrderType.buy ? order.amount : -order.amount);

      assetMap[symbol] ??= order.asset;
    }

    final List<PortfolioModel> holdings = [];

    amountMap.forEach((symbol, amount) {
      if (amount > 0) {
        holdings.add(PortfolioModel(amount: amount, asset: assetMap[symbol]));
      }
    });

    return holdings;
  }

  String get currentPortfolioValue {
    double total = 0.0;
    for (final portfolio in holdingOrders) {
      final symbol = portfolio.asset?.symbol;
      final amount = portfolio.amount ?? 0;

      if (symbol != null) {
        final currentAsset = listAssets.firstWhere(
          (a) => a.symbol?.toLowerCase() == symbol.toLowerCase(),
          orElse: () => AssetModel(price: 0),
        );

        total += amount * (currentAsset.price ?? 0);
      }
    }

    final result = double.parse(total.toStringAsFixed(2));
    return usdCurrency(result);
  }

  void initData() {
    double totalBuy = 0;
    double totalSell = 0;
    log('total data : ${listOrders.length}');
    final jsonList = listOrders.asMap().entries.forEach((entry) {
      final index = entry.key + 1;
      final order = entry.value;
      if (order.type == OrderType.buy) {
        totalBuy += order.amount;
      } else if (order.type == OrderType.sell) {
        totalSell += order.amount;
      }
      log('$index | key: ${order.key} | ${order.type.name} | ${order.symbol} | ${order.amount}');
    });

    log('Total Buy Amount: $totalBuy');
    log('Total Sell Amount: $totalSell');

    // log('list orders : ${listOrders.toString()}');
    // log(jsonEncode(holdingOrders.map((e) => e.toJson()).toList()));
  }

  void navigateToMarketView(AssetModel? asset) {
    if (asset != null) {
      _navigationService.navigateTo(
        Routes.marketView,
        arguments: MarketViewArguments(asset: asset),
      );
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_webSocketService];
}
