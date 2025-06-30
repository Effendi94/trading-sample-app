import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/app/helper/string_extentions.dart';
import 'package:trading_sample_app/ui/shared/circle_avatar_widget.dart';
import 'package:trading_sample_app/ui/views/portfolio/portfolio_viewmodel.dart';

class ListPortfolio extends StackedView<PortfolioViewmodel> {
  const ListPortfolio({super.key});

  @override
  Widget builder(BuildContext context, PortfolioViewmodel viewModel, Widget? child) {
    if (viewModel.holdingOrders.isNotEmpty) {
      return Expanded(
        child: ListView.separated(
          physics: ClampingScrollPhysics(),
          itemCount: viewModel.holdingOrders.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, idx) {
            final item = viewModel.holdingOrders[idx];
            final asset = viewModel.holdingOrders[idx].asset;
            return ListTile(
              onTap: () => viewModel.navigateToMarketView(asset),
              tileColor: CustomColors.neutral40,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              leading: CircleAvatarWidget(radius: 20, isSvg: true, assetPath: asset?.logoAsset),
              title: Text(asset?.name?.toUcWord ?? ''),
              subtitle: Text(
                '${item.amount?.toStringAsFixed(6)} ${asset?.base?.toUpperCase() ?? ''}',
              ),
            );
          },
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: CustomColors.neutral40,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          'No coins owned',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: CustomColors.textPrimary),
        ),
      ),
    );
  }

  @override
  PortfolioViewmodel viewModelBuilder(BuildContext context) => PortfolioViewmodel();
}
