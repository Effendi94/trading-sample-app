import 'package:bcrypt/bcrypt.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/models/profile_model.dart';
import 'package:trading_sample_app/app/services/hive_service.dart';
import 'package:trading_sample_app/app/services/order_service.dart';

class ProfileService with ListenableServiceMixin {
  final _hive = locator<HiveService>();
  final _orderService = locator<OrderService>();
  final ReactiveValue<ProfileModel?> _profile = ReactiveValue(null);

  ProfileModel? get profile => _profile.value;
  double get balance => _profile.value?.balance ?? 0;

  static const _profileKey = 'user';

  ProfileService() {
    listenToReactiveValues([_profile]);
    init();
  }

  Future<void> init() async {
    final box = _hive.profileBox;

    // Create dummy user if none exists
    if (!box.containsKey(_profileKey)) {
      final hashedPass = BCrypt.hashpw('123456', BCrypt.gensalt());
      final dummy = ProfileModel(
        name: 'John Doe',
        email: 'john.doe@example.com',
        password: hashedPass,
        balance: 5000,
      );
      await box.put(_profileKey, dummy);
    }

    getProfile();
  }

  Future<void> getProfile() async {
    _profile.value = _hive.profileBox.get(_profileKey);
    notifyListeners();
  }

  Future<void> updateProfile(ProfileModel updated) async {
    await _hive.profileBox.put(_profileKey, updated);
    _profile.value = updated;
    notifyListeners();
  }

  Future<void> updateBalance(double newBalance) async {
    final updated = _profile.value?.copyWith(balance: newBalance);
    if (updated != null) await updateProfile(updated);
  }

  Future<void> resetBalance() async {
    final current = _hive.profileBox.get(_profileKey);
    if (current != null) {
      final updated = current.copyWith(balance: 5000);
      await updateProfile(updated);
    }
  }

  Future<void> resetProfile() async {
    await resetBalance();
    await _orderService.clearOrders();
    notifyListeners();
  }
}
