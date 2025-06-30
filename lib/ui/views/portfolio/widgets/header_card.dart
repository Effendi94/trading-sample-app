import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/ui/views/portfolio/portfolio_viewmodel.dart';

class HeaderCard extends StackedView<PortfolioViewmodel> {
  const HeaderCard({super.key});

  @override
  Widget builder(BuildContext context, PortfolioViewmodel viewModel, Widget? child) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: CustomColors.brandBlueSecondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 30,
            children: [
              Text(
                'Portfolio',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: CustomColors.neutralWhite),
              ),
              IntrinsicHeight(
                child: Row(
                  spacing: 20,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Invested Value (est)',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(color: CustomColors.neutralWhite),
                        ),
                        Text(
                          '~ 0',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(color: CustomColors.neutralWhite),
                        ),
                      ],
                    ),
                    VerticalDivider(color: CustomColors.neutralWhite, thickness: 2),
                    Column(
                      children: [
                        Text(
                          'Available Balance',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(color: CustomColors.neutralWhite),
                        ),
                        Text(
                          '${viewModel.profileBalance}',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(color: CustomColors.neutralWhite),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  PortfolioViewmodel viewModelBuilder(BuildContext context) => PortfolioViewmodel();
}
