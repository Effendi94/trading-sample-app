import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/ui/views/portfolio/portfolio_viewmodel.dart';
import 'package:trading_sample_app/ui/views/portfolio/widgets/header_card.dart';
import 'package:trading_sample_app/ui/views/portfolio/widgets/list_portfolio.dart';

class PortfolioView extends StackedView<PortfolioViewmodel> {
  const PortfolioView({super.key});

  @override
  void onViewModelReady(PortfolioViewmodel viewModel) {
    viewModel.initData();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, PortfolioViewmodel viewModel, Widget? child) {
    return Scaffold(
      // appBar: AppBar(title: Text('Portfolio')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 30,
            children: [
              HeaderCard(),
              Text(
                'Your coins',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: CustomColors.textPrimary),
              ),
              ListPortfolio(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  PortfolioViewmodel viewModelBuilder(BuildContext context) => PortfolioViewmodel();
}
