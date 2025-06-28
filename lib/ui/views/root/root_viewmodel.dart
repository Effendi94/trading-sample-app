import 'package:stacked/stacked.dart';

class RootViewmodel extends IndexTrackingViewModel {
  RootViewmodel(int initialIndex) {
    setIndex(initialIndex);
  }
  void goToHome() => setIndex(0);
  void goToPortfolio() => setIndex(1);
  void goToProfile() => setIndex(2);
}
