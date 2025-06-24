import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/ui/views/profile/profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewmodel> {
  const ProfileView({super.key});

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold();
  }

  @override
  ProfileViewmodel viewModelBuilder(BuildContext context) => ProfileViewmodel();
}
