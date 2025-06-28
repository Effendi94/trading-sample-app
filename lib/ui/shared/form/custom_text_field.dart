import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool readOnly;
  final Color backgroundColor;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText = '',
    this.readOnly = false,
    this.backgroundColor = Colors.white,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: readOnly ? CustomColors.greyGray4 : backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CustomColors.brandBluePrimary),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: labelText,
          hintStyle: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: CustomColors.textTertiary),
          contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field cannot be empty';
          }
          if (!RegExp(r'^[0-9+ ]+$').hasMatch(value)) {
            return 'Only numbers and + are allowed';
          }
          return null;
        },
      ),
    );
  }
}
