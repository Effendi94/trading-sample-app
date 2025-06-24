import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/ui/views/market/market_viewmodel.dart';

class MarketView extends StackedView<MarketViewmodel> {
  const MarketView({super.key});

  @override
  Widget builder(BuildContext context, MarketViewmodel viewModel, Widget? child) {
    return Scaffold();
  }

  @override
  MarketViewmodel viewModelBuilder(BuildContext context) => MarketViewmodel();
}
