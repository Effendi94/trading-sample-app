import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/ui/views/home/home_view.dart';
import 'package:trading_sample_app/ui/views/portfolio/portfolio_view.dart';
import 'package:trading_sample_app/ui/views/profile/profile_view.dart';
import 'package:trading_sample_app/ui/views/root/root_viewmodel.dart';
import 'package:trading_sample_app/ui/views/root/widgets/bottom_navigation_bar.dart';

class RootView extends StackedView<RootViewmodel> {
  final int pageIndex;

  const RootView({super.key, this.pageIndex = 0});

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
      body: getViewForIndex(viewModel.currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: CustomColors.brandSecondary,
          boxShadow: [
            BoxShadow(
              color: CustomColors.brandSecondary,
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Theme(
          data: ThemeData(splashColor: Colors.transparent, highlightColor: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: BottomNavigationBarWidget(),
          ),
        ),
      ),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return PortfolioView();
      case 2:
        return ProfileView();
      default:
        return HomeView();
    }
  }

  @override
  RootViewmodel viewModelBuilder(BuildContext context) => RootViewmodel(pageIndex);
}
