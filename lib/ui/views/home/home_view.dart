import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/app/helper/ui_helpers.dart';
import 'package:trading_sample_app/ui/views/home/home_viewmodel.dart';

class HomeView extends StackedView<HomeViewmodel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewmodel viewModel, Widget? child) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                  child: Column(children: [Text('Welcome ;;'), Text('Make your investment today')]),
                ),
              ),
              Text('List Coins', style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewmodel viewModelBuilder(BuildContext context) => HomeViewmodel();
}
