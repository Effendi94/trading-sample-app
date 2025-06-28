import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/models/asset_model.dart';
import 'package:trading_sample_app/app/services/binance_websocket_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MarketViewmodel extends ReactiveViewModel {
  final BiWebSocketService _webSocketService = locator<BiWebSocketService>();

  final formKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final buyAmountController = TextEditingController();
  final buySpendController = TextEditingController();
  final buyTotalAmountController = TextEditingController();

  final sellAmountController = TextEditingController();
  final sellSpendController = TextEditingController();
  final sellTotalAmountController = TextEditingController();
  AssetModel? get currentAsset => _webSocketService.currentAsset;
  WebSocketChannel? get channel => _webSocketService.symbolChannel;
  bool get isWebsocketLoading => _webSocketService.isLoading;
  late final VoidCallback _webSocketListener;

  String? validateAmount(String? value) {
    final val = double.tryParse(value ?? '');
    if (val == null || val <= 0) {
      return 'Masukkan jumlah yang valid';
    }
    return null;
  }

  void onBuyChange(String? value, {required bool isCoin}) {
    final double parsed = double.tryParse(value ?? '0') ?? 0;
    final double currentPrice = double.tryParse(priceController.text) ?? 0;

    if (isCoin) {
      // Coin to USD
      final double usd = (parsed * currentPrice);
      final double roundedUsd = (usd * 100).ceilToDouble() / 100;

      buySpendController.text = roundedUsd.toString();
    } else {
      // USD to Coin
      final double coin = parsed / currentPrice;
      buyAmountController.text = coin.toStringAsFixed(2);
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
