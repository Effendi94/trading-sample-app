import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/app/enums/trade_input_type.dart';
import 'package:trading_sample_app/app/helper/format_helpers.dart';
import 'package:trading_sample_app/app/helper/string_extentions.dart';
import 'package:trading_sample_app/app/models/asset_model.dart';
import 'package:trading_sample_app/ui/shared/circle_avatar_widget.dart';
import 'package:trading_sample_app/ui/shared/custom_button.dart';
import 'package:trading_sample_app/ui/shared/form/custom_text_field.dart';
import 'package:trading_sample_app/ui/views/market/market_viewmodel.dart';

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
              children: [
                Expanded(
                  child: Column(
                    spacing: 15,
                    children: [
                      CustomTextField(
                        controller: viewModel.priceController,
                        labelText: 'Price',
                        readOnly: true,
                      ),
                      CustomTextField(
                        controller: viewModel.buyAmountController,
                        labelText: 'You Buy (est)',
                        hintText: '0',
                        onChanged: (value) {
                          viewModel.onBuyChange(value, inputType: TradeInputType.coin);
                        },
                      ),
                      CustomTextField(
                        controller: viewModel.buySpendController,
                        labelText: 'You Spend (est)',
                        hintText: '10 - 10,000',
                        onChanged: (value) {
                          viewModel.onBuyChange(value, inputType: TradeInputType.usd);
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: CustomColors.neutral40,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              spacing: 15,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [Text('Available'), Text(viewModel.avBuyBalance)],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Max Buy'),
                                    Text(
                                      '${viewModel.maxBuy} (${viewModel.currentAsset?.base?.toUpperCase()})',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [Text('est Fee'), Text('0')],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      CustomButton(
                        onPressed: viewModel.onBuyPressed,
                        isDisabled: viewModel.isLoading,
                        text: 'Buy',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 15,
                    children: [
                      CustomTextField(
                        controller: viewModel.priceController,
                        labelText: 'Price',
                        readOnly: true,
                      ),
                      CustomTextField(
                        controller: viewModel.sellAmountController,
                        labelText: 'You Sell',
                        hintText: '0',
                        onChanged: (value) {
                          viewModel.onBuyChange(value, inputType: TradeInputType.coin);
                        },
                      ),
                      CustomTextField(
                        controller: viewModel.sellSpendController,
                        labelText: 'You Receive (est)',
                        hintText: '10 - 10,000',
                        // onChanged: (value) {
                        //   viewModel.onBuyChange(value, inputType: TradeInputType.usd);
                        // },
                        readOnly: true,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: CustomColors.neutral40,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              spacing: 15,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Available'),
                                    Text(
                                      '${viewModel.avSellBalance} (${viewModel.currentAsset?.base?.toUpperCase()})',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [Text('Max Sell (est)'), Text(viewModel.maxSell)],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [Text('est Fee'), Text('0')],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      CustomButton(
                        onPressed: viewModel.onSellPressed,
                        isDisabled: viewModel.isLoading,
                        text: 'Sell',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  MarketViewmodel viewModelBuilder(BuildContext context) => MarketViewmodel();
}
