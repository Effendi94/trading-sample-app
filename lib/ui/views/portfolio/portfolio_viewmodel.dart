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
  bool tes = true;

  List<PortfolioModel> get holdingOrders {
    final List<OrderModel> orders = listOrders;

    final List<PortfolioModel> result = [];

    for (final order in orders) {
      final symbol = order.symbol;

      final existing = result.indexWhere(
        (p) => p.asset?.symbol?.toLowerCase() == symbol.toLowerCase(),
      );

      final delta = order.type == OrderType.buy ? order.amount : -order.amount;

      if (existing != -1) {
        final current = result[existing];
        final updatedAmount = (current.amount ?? 0) + delta;

        result[existing] = current.copyWith(amount: updatedAmount);
      } else {
        result.add(PortfolioModel(amount: delta, asset: order.asset));
      }
    }

    return result.where((p) => (p.amount ?? 0) > 0).toList();
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

  void initData() async {
    // double totalBuy = 0;
    // double totalSell = 0;
    // log('total data : ${listOrders.length}');
    // final jsonList = listOrders.asMap().entries.forEach((entry) {
    //   final index = entry.key + 1;
    //   final order = entry.value;
    //   if (order.type == OrderType.buy) {
    //     totalBuy += order.amount;
    //   } else if (order.type == OrderType.sell) {
    //     totalSell += order.amount;
    //   }
    //   log('$index | key: ${order.key} | ${order.type.name} | ${order.symbol} | ${order.amount}');
    // });

    // log('Total Buy Amount: $totalBuy');
    // log('Total Sell Amount: $totalSell');

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
