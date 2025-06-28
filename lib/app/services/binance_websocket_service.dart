import 'dart:convert';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/common.dart';
import 'package:trading_sample_app/app/constants/endpoint.dart';
import 'package:trading_sample_app/app/models/asset_model.dart';
import 'package:trading_sample_app/app/models/ticker_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BiWebSocketService with ListenableServiceMixin {
  final ReactiveValue<bool> _isLoading = ReactiveValue(true);
  // WebSocketChannel? allSymbolChannel;
  // WebSocketChannel? symbolChannel;
  // final ReactiveValue<WebSocketChannel?> _symbolChannel = ReactiveValue(null);
  // final ReactiveValue<WebSocketChannel?> _allSymbolChannel = ReactiveValue(null);
  final ReactiveValue<AssetModel?> _currentAsset = ReactiveValue(null);
  final ReactiveValue<List<AssetModel>> _listAssets = ReactiveValue<List<AssetModel>>(
    Common.listAssets,
  );

  WebSocketChannel? symbolChannel;
  WebSocketChannel? allSymbolChannel;
  List<AssetModel> get listAssets => _listAssets.value;
  AssetModel? get currentAsset => _currentAsset.value;
  bool get isLoading => _isLoading.value;
  ReactiveValue<AssetModel?> get currentAssetListenable => _currentAsset;

  BiWebSocketService() {
    listenToReactiveValues([_listAssets, _currentAsset]);
  }

  set updateAsset(AssetModel? asset) {
    _currentAsset.value = asset;
  }

  void getAllSymbols() {
    if (allSymbolChannel != null) return;
    _isLoading.value = true;

    final uri = Uri.parse(Endpoint.binanceStreamServer.replaceAll('%STREAM_NAME%', '!ticker@arr'));

    allSymbolChannel = WebSocketChannel.connect(uri);

    allSymbolChannel?.stream.listen(
      (event) {
        final rawList = jsonDecode(event) as List;

        final List<TickerModel?> tickerList =
            rawList.map((item) => TickerModel.fromJson(item as Map<String, dynamic>)).toList();

        final updatedList =
            _listAssets.value.map((existingAsset) {
              TickerModel? match;
              try {
                match = tickerList.firstWhere(
                  (ticker) => ticker?.symbol?.toLowerCase() == existingAsset.symbol,
                );
              } catch (_) {
                match = null;
              }

              if (match != null) {
                return existingAsset.copyWith(price: match.lastPrice);
              }
              return existingAsset;
            }).toList();
        _listAssets.value = updatedList;
        if (_isLoading.value) _isLoading.value = false;
        // notifyListeners();
      },
      onError: (error) {},
      onDone: () {},
    );
  }

  void getSymbol(String? symbol) {
    if (symbolChannel != null) return;
    _isLoading.value = true;

    final uri = Uri.parse(
      Endpoint.binanceStreamServer.replaceAll('%STREAM_NAME%', '$symbol@ticker'),
    );
    symbolChannel = WebSocketChannel.connect(uri);

    symbolChannel?.stream.listen(
      (event) {
        final rawData = jsonDecode(event);
        final TickerModel tickerData = TickerModel.fromJson(rawData);
        // log(jsonEncode(tickerData.toJson()));
        // final AssetModel assetData = AssetModel(
        //   symbol: tickerData.symbol,
        //   price: tickerData.lastPrice,
        // );

        _currentAsset.value = _currentAsset.value?.copyWith(
          symbol: tickerData.symbol,
          price: tickerData.lastPrice,
        );

        // _currentAsset.value = assetData;
        if (_isLoading.value) _isLoading.value = false;
        // notifyListeners();
      },
      onError: (error) {},
      onDone: () {},
    );
  }

  void disconnectSymbolChannel() {
    symbolChannel?.sink.close();
    symbolChannel = null;
  }

  void disconnectAllSymbolChannel() {
    allSymbolChannel?.sink.close();
    allSymbolChannel = null;
  }
}
