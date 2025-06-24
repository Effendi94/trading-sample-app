import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/ui/views/portfolio/portfolio_viewmodel.dart';

class PortfolioView extends StackedView<PortfolioViewmodel> {
  const PortfolioView({super.key});

  @override
  Widget builder(BuildContext context, PortfolioViewmodel viewModel, Widget? child) {
    return Scaffold();
  }

  @override
  PortfolioViewmodel viewModelBuilder(BuildContext context) => PortfolioViewmodel();
}
