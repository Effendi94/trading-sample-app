import 'dart:convert';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/endpoint.dart';
import 'package:trading_sample_app/app/constants/icon_constants.dart';
import 'package:trading_sample_app/app/models/asset_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BiWebSocketService with ListenableServiceMixin {
  final ReactiveValue<bool> _isLoading = ReactiveValue(true);
  final ReactiveValue<bool> _isConnected = ReactiveValue(false);
  final ReactiveValue<List<AssetModel>> _listAssets = ReactiveValue<List<AssetModel>>([
    AssetModel(name: 'bitcoin', base: 'btc', symbol: 'btcusdt', logoAsset: IconConstants.btcIcon),
    AssetModel(name: 'etherium', base: 'eth', symbol: 'ethusdt', logoAsset: IconConstants.ethIcon),
    AssetModel(
      name: 'binance coin',
      base: 'bnb',
      symbol: 'bnbusdt',
      logoAsset: IconConstants.bnbIcon,
    ),
    AssetModel(name: 'solana', base: 'sol', symbol: 'solusdt', logoAsset: IconConstants.solusIcon),
    AssetModel(name: 'cardano', base: 'ada', symbol: 'adausdt', logoAsset: IconConstants.adaIcon),
  ]);

  List<AssetModel> get listAssets => _listAssets.value;

  WebSocketChannel? _channel;
  // Stream? _stream;
  bool get isConnected => _isConnected.value;
  bool get isLoading => _isLoading.value;

  BiWebSocketService() {
    // listenToReactiveValues([_listAssets]);
  }

  void connect() {
    if (_channel != null) return;

    final uri = Uri.parse(Endpoint.binanceStreamServer.replaceAll('%STREAM_NAME%', '!ticker@arr'));

    _channel = WebSocketChannel.connect(uri);
    _isConnected.value = true;

    _channel?.stream.listen(
      (event) {
        final data = jsonDecode(event) as List;
        final updatedList =
            _listAssets.value.map((existingAsset) {
              final match = data.firstWhere(
                (item) => item['s'].toString().toLowerCase() == existingAsset.symbol,
                orElse: () => null,
              );

              if (match != null) {
                final updatedPrice = double.tryParse(match['c'] ?? '0') ?? 0;
                return existingAsset.copyWith(price: updatedPrice);
              }
              return existingAsset;
            }).toList();

        _listAssets.value = updatedList;
        // log(listAssets.toString());
        if (_isLoading.value) _isLoading.value = false;
        notifyListeners();
      },
      onError: (error) {
        _isConnected.value = false;
      },
      onDone: () {
        _isConnected.value = false;
      },
    );
  }

  void disconnect() {
    if (!isConnected) return;

    _channel?.sink.close();
    _channel = null;
    _isConnected.value = false;
  }
}
