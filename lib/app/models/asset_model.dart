class AssetModel {
  final String? symbol;
  final double? price;
  final String? logoAsset;

  AssetModel({this.symbol, this.price, this.logoAsset});

  AssetModel copyWith({String? symbol, double? price, String? logoAsset}) {
    return AssetModel(
      symbol: symbol ?? this.symbol,
      price: price ?? this.price,
      logoAsset: logoAsset ?? this.logoAsset,
    );
  }
}
