import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';
import 'package:trading_sample_app/ui/shared/circle_avatar_widget.dart';
import 'package:trading_sample_app/ui/views/profile/profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewmodel> {
  const ProfileView({super.key});

  @override
  void onViewModelReady(ProfileViewmodel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          spacing: 20,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: CustomColors.brandBlueSecondary,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      CircleAvatarWidget(radius: 50, assetPath: 'assets/images/avatar.png'),
                      Text(
                        '${viewModel.profile?.name}',
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge?.copyWith(color: CustomColors.neutralWhite),
                      ),
                      Text(
                        '${viewModel.profile?.email}',
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge?.copyWith(color: CustomColors.neutralWhite),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: viewModel.listProfileNav.length,
                separatorBuilder: (_, __) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final item = viewModel.listProfileNav[index];
                  return ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    tileColor: CustomColors.neutral40,
                    leading: Icon(item['icon']),
                    title: Text(item['title']),
                    subtitle: item['subtitle'] != null ? Text(item['subtitle']) : null,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: item['onTap'] as void Function(),
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
  ProfileViewmodel viewModelBuilder(BuildContext context) => ProfileViewmodel();
}
