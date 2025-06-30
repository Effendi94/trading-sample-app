import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/app/helper/format_helpers.dart';
import 'package:trading_sample_app/app/helper/string_extentions.dart';
import 'package:trading_sample_app/app/models/asset_model.dart';
import 'package:trading_sample_app/ui/shared/circle_avatar_widget.dart';
import 'package:trading_sample_app/ui/views/market/market_viewmodel.dart';
import 'package:trading_sample_app/ui/views/market/widgets/sell_widget.dart';

import 'widgets/buy_widget.dart';

class MarketView extends StackedView<MarketViewmodel> {
  final AssetModel asset;
  const MarketView({super.key, required this.asset});

  @override
  void onViewModelReady(MarketViewmodel viewModel) {
    viewModel.getSymbolData(asset);
    viewModel.loadOwnedCoin(asset);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, MarketViewmodel viewModel, Widget? child) {
    final assetName = viewModel.currentAsset?.name?.toUcWord;
    final assetBase = viewModel.currentAsset?.base?.toUpperCase();
    final assetSymbol = viewModel.currentAsset?.symbol?.toUpperCase();
    final assetPrice = viewModel.currentAsset?.price;
    return Scaffold(
      appBar: AppBar(title: Text('$assetName ($assetBase)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 15,
          children: [
            Text(
              'Market Price',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: CustomColors.textPrimary, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatarWidget(radius: 20, isSvg: true, assetPath: asset.logoAsset),
                const SizedBox(width: 5),
                Text(
                  '$assetSymbol',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: CustomColors.textPrimary, fontSize: 20),
                ),
                const SizedBox(width: 10),
                Text(
                  usdCurrency(assetPrice),
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: CustomColors.textPrimary, fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [BuyWidget(), SellWidget()],
            ),
          ],
        ),
      ),
    );
  }

  @override
  MarketViewmodel viewModelBuilder(BuildContext context) => MarketViewmodel();
}
