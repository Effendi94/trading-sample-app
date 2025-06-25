class AssetModel {
  final String? name;
  final String? base;
  final String? symbol;
  final double? price;
  final String? logoAsset;

  AssetModel({this.name, this.base, this.symbol, this.price = 0, this.logoAsset});

  AssetModel copyWith({
    String? name,
    String? base,
    String? symbol,
    double? price,
    String? logoAsset,
  }) {
    return AssetModel(
      name: name ?? this.name,
      base: base ?? this.base,
      symbol: symbol ?? this.symbol,
      price: price ?? this.price,
      logoAsset: logoAsset ?? this.logoAsset,
    );
  }

  @override
  String toString() {
    return 'AssetModel(name: $name, base: $base, symbol: $symbol, price: $price, logoAsset: $logoAsset)';
  }
}
