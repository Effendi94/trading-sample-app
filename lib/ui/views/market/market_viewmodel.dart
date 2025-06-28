import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/enums/snackbar_type.dart';
import 'package:trading_sample_app/app/models/asset_model.dart';
import 'package:trading_sample_app/app/models/order_model.dart';
import 'package:trading_sample_app/app/models/profile_model.dart';
import 'package:trading_sample_app/app/services/binance_websocket_service.dart';
import 'package:trading_sample_app/app/services/order_service.dart';
import 'package:trading_sample_app/app/services/profile_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MarketViewmodel extends ReactiveViewModel {
  final BiWebSocketService _webSocketService = locator<BiWebSocketService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final OrderService _orderService = locator<OrderService>();
  final ProfileService _profileService = locator<ProfileService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  final priceController = TextEditingController();
  final buyAmountController = TextEditingController();
  final buySpendController = TextEditingController();
  final buyTotalAmountController = TextEditingController();

  final sellAmountController = TextEditingController();
  final sellSpendController = TextEditingController();
  final sellTotalAmountController = TextEditingController();
  AssetModel? get currentAsset => _webSocketService.currentAsset;
  WebSocketChannel? get channel => _webSocketService.symbolChannel;
  ProfileModel? get profile => _profileService.profile;
  bool get isWebsocketLoading => _webSocketService.isLoading;
  late final VoidCallback _webSocketListener;

  Future<void> onBuyPressed() async {
    try {
      final String currentSymbol = currentAsset?.symbol ?? '';
      final double currentPrice = currentAsset?.price ?? 0;
      final double currentAmount = double.tryParse(buyAmountController.text) ?? 0;

      final order = OrderModel(
        type: OrderType.buy,
        symbol: currentSymbol,
        amount: currentAmount,
        price: currentPrice,
        timestamp: DateTime.now(),
      );
      validateOrderInputs(order);
      log(order.toString());
      // _snackbarService.showCustomSnackBar(
      //   onTap: () => _navigationService.back(),
      //   duration: const Duration(seconds: 3),
      //   variant: SnackbarType.error,
      //   title: 'Gagal',
      //   message: 'Testing snackbar message',
      // );

      // await _orderService.placeOrder(order);
    } catch (e, stackTrace) {
      log('Buy Order Error: $e', stackTrace: stackTrace);
      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.error,
        title: 'Order Failed',
        message: 'Something wrong when processing your order, try again!',
      );
    }
  }

  Future<void> onSellPressed(String symbol, double amount, double price) async {
    final order = OrderModel(
      type: OrderType.sell,
      symbol: symbol,
      amount: amount,
      price: price,
      timestamp: DateTime.now(),
    );
    await _orderService.placeOrder(order);
  }

  void validateOrderInputs(OrderModel orderModel) {
    late String message = '';
    if (orderModel.symbol.isEmpty) message = 'Symbol is required.';
    if (orderModel.amount <= 0) message = 'Amount must be greater than 0.';
    if (orderModel.price <= 0) message = 'Price must be greater than 0.';

    if (orderModel.total > profile!.balance) {
      message = 'Insufficient balance. You need \$${orderModel.total.toStringAsFixed(2)}.';
    }

    _snackbarService.showCustomSnackBar(
      onTap: () => _navigationService.back(),
      variant: SnackbarType.error,
      title: 'Gagal',
      message: message,
    );
  }

  void onBuyChange(String? value, {required bool isCoin}) {
    final double parsed = double.tryParse(value ?? '0') ?? 0;
    final double currentPrice = double.tryParse(priceController.text) ?? 0;

    if (isCoin) {
      // Coin to USD
      final double usd = (parsed * currentPrice);
      final double roundedUsd = (usd * 100).ceilToDouble() / 100;

      buySpendController.text = roundedUsd.toStringAsFixed(2);
    } else {
      // USD to Coin
      // final double coin = parsed / currentPrice;
      final double coin = parsed / currentPrice;
      final double roundedCoin = (coin * 100).ceilToDouble() / 100;
      buyAmountController.text = roundedCoin.toStringAsFixed(2);
    }
  }

  void getSymbolData(AssetModel asset) {
    _webSocketService.updateAsset = asset;
    _webSocketService.getSymbol(asset.symbol);
  }

  void disposeAllcontroller() {
    priceController.dispose();
    buyAmountController.dispose();
    buySpendController.dispose();
    buyTotalAmountController.dispose();
    sellAmountController.dispose();
    sellSpendController.dispose();
    sellTotalAmountController.dispose();
  }

  @override
  void dispose() {
    debugPrint('disconnecting');
    disposeAllcontroller();
    _webSocketService.disconnectSymbolChannel();
    _webSocketService.removeListener(_webSocketListener);
    super.dispose();
  }

  MarketViewmodel() {
    _webSocketListener = () {
      final asset = _webSocketService.currentAsset;
      if (asset != null) {
        // Update controller.text safely
        SchedulerBinding.instance.addPostFrameCallback((_) {
          priceController.text = '${asset.price}';
        });
        notifyListeners();
      }
    };
    _webSocketService.addListener(_webSocketListener);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_webSocketService];
}
