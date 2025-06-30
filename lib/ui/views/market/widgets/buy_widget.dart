import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/app/enums/trade_input_type.dart';
import 'package:trading_sample_app/ui/shared/custom_button.dart';
import 'package:trading_sample_app/ui/shared/form/custom_text_field.dart';
import 'package:trading_sample_app/ui/views/market/market_viewmodel.dart';

class BuyWidget extends StackedView<MarketViewmodel> {
  const BuyWidget({super.key});

  @override
  Widget builder(BuildContext context, MarketViewmodel viewModel, Widget? child) {
    return Expanded(
      child: Column(
        spacing: 15,
        children: [
          CustomTextField(
            controller: viewModel.priceController,
            labelText: 'Price',
            readOnly: true,
          ),
          CustomTextField(
            controller: viewModel.buyCoinController,
            labelText: 'You Buy (est)',
            hintText: '0',
            readOnly: viewModel.isLoading ? true : false,
            onChanged: (value) {
              viewModel.onBuyChange(value, inputType: TradeInputType.coin);
            },
          ),
          CustomTextField(
            controller: viewModel.buyUsdController,
            labelText: 'You Spend (est)',
            hintText: '10 - 10,000',
            readOnly: viewModel.isLoading ? true : false,
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
    );
  }

  @override
  MarketViewmodel viewModelBuilder(BuildContext context) => MarketViewmodel();
}
