import 'package:flutter/material.dart';
import '../constants/common.dart';
import '../constants/custom_colors.dart';
import 'app_text_theme.dart';

ThemeData appThemeData(BuildContext context) {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: CustomColors.brandBluePrimary),
    fontFamily: Common.defaultFontFamily,
    textTheme: AppTextTheme.getThemeText(),
    scaffoldBackgroundColor: CustomColors.brandPrimary,
    primaryColor: CustomColors.textWhite,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return const Color(0xffCED3D7);
          }
          return CustomColors.brandBlueSecondary;
        }),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
    ),
  );
}
