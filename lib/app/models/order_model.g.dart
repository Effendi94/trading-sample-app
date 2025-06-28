// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 1;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      symbol: fields[0] as String,
      price: fields[1] as double,
      amount: fields[2] as double,
      type: fields[3] as OrderType,
      timestamp: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.symbol)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderTypeAdapter extends TypeAdapter<OrderType> {
  @override
  final int typeId = 0;

  @override
  OrderType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return OrderType.buy;
      case 1:
        return OrderType.sell;
      default:
        return OrderType.buy;
    }
  }

  @override
  void write(BinaryWriter writer, OrderType obj) {
    switch (obj) {
      case OrderType.buy:
        writer.writeByte(0);
        break;
      case OrderType.sell:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
