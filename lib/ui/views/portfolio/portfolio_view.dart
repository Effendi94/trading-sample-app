import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/ui/views/portfolio/portfolio_viewmodel.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          spacing: 30,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
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
                                  'Invested Value',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: CustomColors.neutralWhite,
                                  ),
                                ),
                                Text(
                                  '0',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: CustomColors.neutralWhite,
                                  ),
                                ),
                              ],
                            ),
                            VerticalDivider(color: CustomColors.neutralWhite, thickness: 2),
                            Column(
                              children: [
                                Text(
                                  'Available Balance',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: CustomColors.neutralWhite,
                                  ),
                                ),
                                Text(
                                  '0',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: CustomColors.neutralWhite,
                                  ),
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
            ),
            Text(
              'Your coins',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: CustomColors.textPrimary),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: viewModel.listOrders.length,
              itemBuilder: (context, idx) {
                final order = viewModel.listOrders[idx];
                return ListTile(
                  title: Text('${order.type} ${order.symbol}'),
                  subtitle: Text(
                    '${order.amount} × \$${order.price.toStringAsFixed(2)} = \$${order.total.toStringAsFixed(2)}',
                  ),
                  trailing: Text(
                    '${order.timestamp.hour}:${order.timestamp.minute.toString().padLeft(2, '0')}',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  PortfolioViewmodel viewModelBuilder(BuildContext context) => PortfolioViewmodel();
}
