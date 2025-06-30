import 'package:hive/hive.dart';
import 'package:trading_sample_app/app/models/asset_model.dart';

part 'order_model.g.dart';

@HiveType(typeId: 0)
enum OrderType {
  @HiveField(0)
  buy,
  @HiveField(1)
  sell,
}

@HiveType(typeId: 1)
class OrderModel extends HiveObject {
  @HiveField(0)
  String symbol;

  @HiveField(1)
  double price;

  @HiveField(2)
  double amount;

  @HiveField(3)
  OrderType type;

  @HiveField(4)
  DateTime timestamp;

  AssetModel? asset;

  OrderModel({
    required this.symbol,
    required this.price,
    required this.amount,
    required this.type,
    required this.timestamp,
    this.asset,
  });

  double get total => price * amount;

  OrderModel copyWith({
    String? symbol,
    double? price,
    double? amount,
    OrderType? type,
    DateTime? timestamp,
    AssetModel? asset,
  }) {
    return OrderModel(
      symbol: symbol ?? this.symbol,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      asset: asset ?? this.asset,
    );
  }

  @override
  String toString() {
    return 'OrderModel(symbol: $symbol, price: $price, amount: $amount, type: $type, timestamp: $timestamp, total: $total, asset: ${asset.toString()})';
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'amount': amount,
      'price': price,
      'type': type.name,
      'timestamp': timestamp.toIso8601String(),
      'total': total,
      'asset': asset.toString(),
    };
  }
}
