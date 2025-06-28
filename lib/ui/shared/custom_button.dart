import 'package:flutter/material.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final bool isWhite;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonStyle,
    this.textStyle,
    this.isWhite = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style:
          buttonStyle ??
          ButtonStyle(
            elevation: isWhite ? WidgetStateProperty.all(0) : null,
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return const Color(0xffCED3D7);
              }
              return isWhite ? CustomColors.neutralWhite : CustomColors.brandBluePrimary;
            }),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            overlayColor: isWhite ? WidgetStateProperty.all(Colors.transparent) : null,
          ),
      child: Text(
        text,
        style:
            textStyle ??
            TextStyle(
              color: isWhite ? CustomColors.brandBluePrimary : CustomColors.neutralWhite,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
