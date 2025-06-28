import 'package:hive_flutter/hive_flutter.dart';
import 'package:trading_sample_app/app/models/order_model.dart';
import 'package:trading_sample_app/app/models/profile_model.dart';

class HiveService {
  Box<OrderModel> get orderBox => Hive.box<OrderModel>('orders');
  Box<ProfileModel> get profileBox => Hive.box<ProfileModel>('profile');

  Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(OrderTypeAdapter());
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(OrderModelAdapter());
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(ProfileModelAdapter());

    await Hive.openBox<OrderModel>('orders');
    await Hive.openBox<ProfileModel>('profile');
  }
}
