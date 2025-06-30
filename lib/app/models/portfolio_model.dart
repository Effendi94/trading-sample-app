import 'package:trading_sample_app/app/models/asset_model.dart';

class PortfolioModel {
  final double? amount;
  final AssetModel? asset;

  PortfolioModel({this.amount, this.asset});

  PortfolioModel copyWith({double? amount, AssetModel? asset}) {
    return PortfolioModel(amount: amount ?? this.amount, asset: asset ?? this.asset);
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'asset': asset?.toString(), // Make sure AssetModel has toJson()
    };
  }
}
