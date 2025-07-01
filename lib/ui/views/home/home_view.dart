import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/app/helper/format_helpers.dart';
import 'package:trading_sample_app/app/helper/string_extentions.dart';
import 'package:trading_sample_app/app/helper/ui_helpers.dart';
import 'package:trading_sample_app/ui/shared/circle_avatar_widget.dart';
import 'package:trading_sample_app/ui/shared/shimmer_widget.dart';
import 'package:trading_sample_app/ui/views/home/home_viewmodel.dart';

class HomeView extends StackedView<HomeViewmodel> {
  const HomeView({super.key});

  // @override
  // void onViewModelReady(HomeViewmodel viewModel) {
  //   viewModel.initData();
  //   super.onViewModelReady(viewModel);
  // }

  @override
  Widget builder(BuildContext context, HomeViewmodel viewModel, Widget? child) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Container(
              width: screenWidth(context),
              decoration: BoxDecoration(
                color: CustomColors.blue50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Welcome Trader',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: CustomColors.textWhite),
                    ),
                    Text(
                      'Make your investment today',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: CustomColors.textWhite),
                    ),
                  ],
                ),
              ),
            ),
            Text('List Coins', style: Theme.of(context).textTheme.labelLarge),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: viewModel.listAssets.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, idx) {
                  final asset = viewModel.listAssets[idx];
                  return ListTile(
                    onTap: () => viewModel.navigateToMarketView(asset),
                    tileColor: CustomColors.neutral40,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    leading: CircleAvatarWidget(
                      radius: 20,
                      isSvg: true,
                      assetPath: asset.logoAsset,
                    ),
                    title: Text(asset.name?.toUcWord ?? ''),
                    subtitle: Text(asset.base?.toUpperCase() ?? ''),
                    trailing:
                        viewModel.isWebsocketLoading
                            ? ShimmerWidget(width: screenWidth(context) * .08)
                            : Text(
                              usdCurrency(asset.price),
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(color: CustomColors.black),
                            ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewmodel viewModelBuilder(BuildContext context) => HomeViewmodel();
}
