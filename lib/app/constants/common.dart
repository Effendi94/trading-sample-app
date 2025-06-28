import 'package:trading_sample_app/app/constants/icon_constants.dart';
import 'package:trading_sample_app/app/models/asset_model.dart';

class Common {
  static const titleBar = 'Trading Simple App';
  static const defaultFontFamily = 'Poppins';

  static List<AssetModel> listAssets = [
    AssetModel(name: 'bitcoin', base: 'btc', symbol: 'btcusdt', logoAsset: IconConstants.btcIcon),
    AssetModel(name: 'ethereum', base: 'eth', symbol: 'ethusdt', logoAsset: IconConstants.ethIcon),
    AssetModel(
      name: 'binance coin',
      base: 'bnb',
      symbol: 'bnbusdt',
      logoAsset: IconConstants.bnbIcon,
    ),
    AssetModel(name: 'solana', base: 'sol', symbol: 'solusdt', logoAsset: IconConstants.solusIcon),
    AssetModel(name: 'cardano', base: 'ada', symbol: 'adausdt', logoAsset: IconConstants.adaIcon),
  ];
}
