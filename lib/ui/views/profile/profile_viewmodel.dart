import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:trading_sample_app/app/app.locator.dart';
import 'package:trading_sample_app/app/enums/snackbar_type.dart';
import 'package:trading_sample_app/app/models/profile_model.dart';
import 'package:trading_sample_app/app/services/order_service.dart';
import 'package:trading_sample_app/app/services/profile_service.dart';

class ProfileViewmodel extends BaseViewModel {
  final ProfileService _profileService = locator<ProfileService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final OrderService _orderService = locator<OrderService>();

  ProfileModel? get profile => _profileService.profile;

  List<Map<String, dynamic>> listProfileNav = [];

  void init() {
    listProfileNav = [
      {'icon': Icons.account_balance, 'title': 'Bank Details', 'onTap': () => onNavClick()},
      {'icon': Icons.security, 'title': 'Security', 'onTap': () => onNavClick()},
      {'icon': Icons.help, 'title': 'Help and Support', 'onTap': () => onNavClick()},
      {'icon': Icons.policy, 'title': 'Terms and Conditions', 'onTap': () => onNavClick()},
      {
        'icon': Icons.delete,
        'title': 'Reset Data',
        'subtitle': 'Reset all trading data (orders, balance) for testing purpose (dev)',
        'onTap': () => resetAllData(),
      },
    ];
  }

  void resetAllData() {
    _orderService.clearOrders();
    _profileService.resetBalance();
    _snackbarService.showCustomSnackBar(
      message: 'All data has been successfully reset',
      variant: SnackbarType.info,
    );
  }

  void onNavClick() {
    if (_snackbarService.isSnackbarOpen) {
      _snackbarService.closeSnackbar();
    }
    _snackbarService.showCustomSnackBar(message: 'Comming Soon!', variant: SnackbarType.info);
  }
}
