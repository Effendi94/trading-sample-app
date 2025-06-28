import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/models/order_model.dart';

class HiveService with ListenableServiceMixin {
  late Box<OrderModel> orderBox;
  // late Box<ProfileModel> profileBox;

  final ReactiveValue<List<OrderModel>> _orders = ReactiveValue([]);
  // ReactiveValue<ProfileModel?> _profile = ReactiveValue(null);

  List<OrderModel> get orders => _orders.value;
  // ProfileModel? get profile => _profile.value;

  Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(OrderTypeAdapter());
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(OrderModelAdapter());
    // if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(ProfileModelAdapter());

    orderBox = await Hive.openBox<OrderModel>('orders');
    // profileBox = await Hive.openBox<ProfileModel>('profile');

    // Initial load
    _orders.value = orderBox.values.toList().reversed.toList();
    // _profile.value = profileBox.get('user');

    // Reactive listeners
    listenToReactiveValues([
      _orders,
      // _profile
    ]);
  }
}
