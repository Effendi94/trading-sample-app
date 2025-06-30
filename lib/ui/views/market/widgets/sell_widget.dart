import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/app/enums/trade_input_type.dart';
import 'package:trading_sample_app/ui/shared/custom_button.dart';
import 'package:trading_sample_app/ui/shared/form/custom_text_field.dart';
import 'package:trading_sample_app/ui/views/market/market_viewmodel.dart';

class SellWidget extends StackedView<MarketViewmodel> {
  const SellWidget({super.key});

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
            controller: viewModel.sellCoinController,
            labelText: 'You Sell',
            hintText: '0',
            readOnly: viewModel.isLoading ? true : false,
            onChanged: (value) {
              viewModel.onSellChange(value, inputType: TradeInputType.coin);
            },
          ),
          CustomTextField(
            controller: viewModel.sellUsdController,
            labelText: 'You Receive (est)',
            hintText: '10 - 10,000',
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
    );
  }

  @override
  MarketViewmodel viewModelBuilder(BuildContext context) => MarketViewmodel();
}
