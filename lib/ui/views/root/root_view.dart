import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/ui/views/home/home_view.dart';
import 'package:trading_sample_app/ui/views/market/market_view.dart';
import 'package:trading_sample_app/ui/views/portfolio/portfolio_view.dart';
import 'package:trading_sample_app/ui/views/profile/profile_view.dart';
import 'package:trading_sample_app/ui/views/root/root_viewmodel.dart';
import 'package:trading_sample_app/ui/views/root/widgets/bottom_navigation_bar.dart';

class RootView extends StackedView<RootViewmodel> {
  const RootView({super.key});

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
      body: IndexedStack(
        index: viewModel.currentIndex,
        children: const [HomeView(), MarketView(), PortfolioView(), ProfileView()],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: CustomColors.brandSecondary,
          boxShadow: [
            BoxShadow(color: CustomColors.brandSecondary, blurRadius: 10, spreadRadius: 0, offset: const Offset(0, -2)),
          ],
        ),
        child: Theme(
          data: ThemeData(splashColor: Colors.transparent, highlightColor: Colors.transparent),
          child: Padding(padding: const EdgeInsets.fromLTRB(20, 5, 20, 10), child: BottomNavigationBarWidget()),
        ),
      ),
    );
  }

  @override
  RootViewmodel viewModelBuilder(BuildContext context) => RootViewmodel();
}
