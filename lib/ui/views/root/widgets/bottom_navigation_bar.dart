import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/app/constants/icon_constants.dart';
import 'package:trading_sample_app/app/helper/string_extentions.dart';
import 'package:trading_sample_app/app/models/static_model.dart';
import 'package:trading_sample_app/ui/views/root/root_viewmodel.dart';

final List<StaticModel> bottomNavigationList = [
  StaticModel(code: IconConstants.homeIcon, desc: 'home'),
  // StaticModel(code: IconConstants.marketIcon, desc: 'market'),
  StaticModel(code: IconConstants.portfolioIcon, desc: 'portfolio'),
  StaticModel(code: IconConstants.profileIcon, desc: 'profile'),
];

class BottomNavigationBarWidget extends ViewModelWidget<RootViewmodel> {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context, RootViewmodel viewModel) {
    return BottomNavigationBar(
      currentIndex: viewModel.currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      onTap: viewModel.onClickBottomBar,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      items:
          bottomNavigationList.asMap().entries.map((entry) {
            final int index = entry.key;
            final StaticModel item = entry.value;
            final String? icon = item.code;
            return BottomNavigationBarItem(
              icon: Container(
                // width: 50,
                // height: 35,
                decoration: BoxDecoration(
                  color:
                      viewModel.isIndexSelected(index)
                          ? CustomColors.brandBluePrimary
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child:
                    (icon != null)
                        ? SvgPicture.asset(
                          icon,
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        )
                        : const SizedBox.shrink(),
              ),
              label: item.desc?.toUcWord,
            );
          }).toList(),
    );
  }
}
