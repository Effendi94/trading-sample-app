import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/ui/views/order/order_viewmodel.dart';

class OrderView extends StackedView<OrderViewmodel> {
  const OrderView({super.key});

  // @override
  // void onViewModelReady(OrderViewmodel viewModel) {
  //   viewModel.getSymbolData(asset);
  //   super.onViewModelReady(viewModel);
  // }

  @override
  Widget builder(BuildContext context, OrderViewmodel viewModel, Widget? child) {
    return Scaffold();
  }

  @override
  OrderViewmodel viewModelBuilder(BuildContext context) => OrderViewmodel();
}
