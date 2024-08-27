import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled,
    this.prefixIcon,
    this.hintText,
    this.labelText,
    this.validator,
    this.onTap,
    this.suffixIcon,
    this.keyboardType,
    this.maxLength,
    this.onChanged,
    this.errorMaxLength,
  });
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final bool? enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? errorMaxLength;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: textTheme.titleMedium!.copyWith(color: AppColors.appBlack),
      obscureText: obscureText,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (event) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      decoration: InputDecoration(
        // isCollapsed: true,
        // isDense: true,
        counterText: '',
        filled: true,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(8),
        prefixIcon: prefixIcon,
        prefixIconColor:
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return AppColors.primary;
          }
          if (states.contains(MaterialState.error)) {
            return AppColors.red;
          }
          return Colors.grey;
        }),
        suffixIcon: suffixIcon,
        hintText: hintText,
        label: labelText == null ? null : Text(labelText!),
        errorMaxLines: errorMaxLength,
      ),
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      enabled: enabled,
      onTap: onTap,
    );
  }
}
