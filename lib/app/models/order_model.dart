import 'package:hive/hive.dart';

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

  OrderModel({
    required this.symbol,
    required this.price,
    required this.amount,
    required this.type,
    required this.timestamp,
  });

  double get total => price * amount;

  @override
  String toString() {
    return 'OrderModel(symbol: $symbol, price: $price, amount: $amount, type: $type, timestamp: $timestamp, total: $total)';
  }
}
