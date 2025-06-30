import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/app.router.dart';
import 'package:trading_sample_app/app/enums/snackbar_type.dart';
import 'package:trading_sample_app/app/enums/trade_input_type.dart';
import 'package:trading_sample_app/app/helper/format_helpers.dart';
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
  final ReactiveValue<bool> _isLoading = ReactiveValue<bool>(false);
  final ReactiveValue<double> _currentOwned = ReactiveValue<double>(0.0);

  final priceController = TextEditingController();
  final buyAmountController = TextEditingController();
  final buySpendController = TextEditingController();

  final sellAmountController = TextEditingController();
  final sellSpendController = TextEditingController();
  AssetModel? get currentAsset => _webSocketService.currentAsset;
  WebSocketChannel? get channel => _webSocketService.symbolChannel;
  ProfileModel? get profile => _profileService.profile;
  bool get isWebsocketLoading => _webSocketService.isLoading;
  bool get isLoading => _isLoading.value;
  double get currentOwned => _currentOwned.value;
  late final VoidCallback _webSocketListener;
  TradeInputType _lastInputType = TradeInputType.usd;

  String get avBuyBalance {
    return usdCurrency(_profileService.balance);
  }

  String get maxBuy {
    final double currentPrice = currentAsset?.price ?? 0;
    if (currentPrice <= 0) return '0.00';
    final double coin = _profileService.balance / currentPrice;
    final double roundedCoin = (coin * 100).ceilToDouble() / 100;
    return roundedCoin.toStringAsFixed(2);
  }

  String get avSellBalance {
    // return '';
    return currentOwned.toString();
  }

  String get maxSell {
    final currentPrice = currentAsset?.price;
    if (currentPrice != null) {
      final usd = currentOwned * currentPrice;
      final result = (usd * 100).ceilToDouble() / 100;
      return usdCurrency(result);
    }
    return '0';
  }

  Future<void> onBuyPressed() async {
    try {
      _isLoading.value = true;
      final String currentSymbol = currentAsset?.symbol ?? '';
      final double currentPrice = currentAsset?.price ?? 0;
      final double profileBalance = profile?.balance ?? 0;

      double usdAmount = 0;
      double coinAmount = 0;

      switch (_lastInputType) {
        case TradeInputType.coin:
          coinAmount = double.tryParse(buyAmountController.text) ?? 0;
          coinAmount = (coinAmount * 1000000).floorToDouble() / 1000000;
          usdAmount = coinAmount * currentPrice;
          usdAmount = (usdAmount * 100).floorToDouble() / 100;
          break;

        case TradeInputType.usd:
          usdAmount = double.tryParse(buySpendController.text) ?? 0;
          usdAmount = (usdAmount * 100).floorToDouble() / 100;
          coinAmount = usdAmount / currentPrice;
          coinAmount = (coinAmount * 1000000).floorToDouble() / 1000000;
          break;
      }

      final order = OrderModel(
        type: OrderType.buy,
        symbol: currentSymbol,
        amount: coinAmount,
        price: currentPrice,
        timestamp: DateTime.now(),
      );

      validateBuyInputs(order);

      await _orderService.placeOrder(order);
      final double newBalance = profileBalance - usdAmount;
      await _profileService.updateBalance(newBalance);
      navigateToPortfolio();
    } on FormatException catch (e) {
      _snackbarService.showCustomSnackBar(
        onTap: () => _navigationService.back(),
        variant: SnackbarType.error,
        title: 'Failed',
        message: e.message,
      );
    } catch (e, stackTrace) {
      log('Buy Order Error: $e', stackTrace: stackTrace);
      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.error,
        title: 'Order Failed',
        message: 'Something went wrong while processing your order.',
      );
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> onSellPressed() async {
    try {
      _isLoading.value = true;
      final String currentSymbol = currentAsset?.symbol ?? '';
      final double currentPrice = currentAsset?.price ?? 0;
      final double usdAmount = double.tryParse(sellSpendController.text) ?? 0;
      final double coinAmount = usdAmount / currentPrice;
      final double finalCoinAmount = (coinAmount * 100).floorToDouble() / 100;

      final order = OrderModel(
        type: OrderType.sell,
        symbol: currentSymbol,
        amount: finalCoinAmount,
        price: currentPrice,
        timestamp: DateTime.now(),
      );
      log(order.toString());
      return;
      validateBuyInputs(order);
      await Future.delayed(Duration(seconds: 2));
      await _orderService.placeOrder(order);
      navigateToPortfolio();
    } on FormatException catch (e) {
      _snackbarService.showCustomSnackBar(
        onTap: () => _navigationService.back(),
        variant: SnackbarType.error,
        title: 'Failed',
        message: e.message,
      );
    } catch (e, stackTrace) {
      log('Buy Order Error: $e', stackTrace: stackTrace);
      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.error,
        title: 'Order Failed',
        message: 'Something wrong when processing your order, try again!',
      );
    } finally {
      _isLoading.value = false; // ✅ Always reset loading here
    }
  }

  void navigateToPortfolio() {
    _navigationService.clearStackAndShow(
      Routes.rootView,
      arguments: const RootViewArguments(pageIndex: 1),
    );
  }

  void validateBuyInputs(OrderModel orderModel) {
    if (orderModel.symbol.isEmpty) {
      throw FormatException('Symbol is required.');
    }
    if (orderModel.amount <= 0) {
      throw FormatException('Amount must be greater than 0.');
    }
    if (orderModel.price <= 0) {
      throw FormatException('Price must be greater than 0.');
    }
    if (orderModel.total > profile!.balance) {
      throw FormatException(
        'Insufficient balance. You need \$${orderModel.total.toStringAsFixed(2)}.',
      );
    }
  }

  void onBuyChange(String? value, {required TradeInputType inputType}) {
    _lastInputType = inputType;
    final double parsed = double.tryParse(value ?? '0') ?? 0;
    final double currentPrice = double.tryParse(priceController.text) ?? 0;
    switch (inputType) {
      case TradeInputType.coin:
        final double usd = parsed * currentPrice;
        final double roundedUsd = (usd * 100).floorToDouble() / 100;
        buySpendController.text = roundedUsd.toStringAsFixed(2);
        break;
      case TradeInputType.usd:
        final double coin = parsed / currentPrice;
        final double roundedCoin = (coin * 100).floorToDouble() / 100;
        buyAmountController.text = roundedCoin.toStringAsFixed(2);
        break;
    }
  }

  Future<void> loadOwnedCoin(AssetModel asset) async {
    final symbol = asset.symbol;
    if (symbol == null || symbol.isEmpty) return;
    final result = await _orderService.coinBalance(symbol);
    _currentOwned.value = result;
    notifyListeners();
  }

  void getSymbolData(AssetModel asset) {
    _webSocketService.updateAsset = asset;
    _webSocketService.getSymbol(asset.symbol);
  }

  void resetInputs() {
    buyAmountController.clear();
    buySpendController.clear();
    sellAmountController.clear();
    sellSpendController.clear();
  }

  void disposeAllcontroller() {
    priceController.dispose();
    buyAmountController.dispose();
    buySpendController.dispose();
    sellAmountController.dispose();
    sellSpendController.dispose();
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
