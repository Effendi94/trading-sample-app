import 'dart:convert';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/endpoint.dart';
import 'package:trading_sample_app/app/constants/icon_constants.dart';
import 'package:trading_sample_app/app/models/asset_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BiWebSocketService with ListenableServiceMixin {
  final RxValue<List<AssetModel>> _listAssets = RxValue<List<AssetModel>>([
    AssetModel(symbol: 'btcusdt', logoAsset: IconConstants.btcIcon),
    AssetModel(symbol: 'ethusdt', logoAsset: IconConstants.ethIcon),
    AssetModel(symbol: 'bnbusdt', logoAsset: IconConstants.bnbIcon),
    AssetModel(symbol: 'solusdt', logoAsset: IconConstants.solusIcon),
    AssetModel(symbol: 'adausdt', logoAsset: IconConstants.adaIcon),
  ]);

  List<AssetModel> get listAssets => _listAssets.value;

  late final WebSocketChannel _channel;
  BiWebSocketService() {
    listenToReactiveValues([_listAssets]);
    final uri = Uri.parse(
      Endpoint.binanceStreamServer.replaceAll('%STREAM_NAME%', '!miniTicker@arr'),
    );
    _channel = WebSocketChannel.connect(uri);
    _channel.stream.listen((event) {
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
      // notifyListeners();
    });
  }
}
