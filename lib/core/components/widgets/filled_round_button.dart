import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class FilledRoundButton extends StatelessWidget {
  const FilledRoundButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor = AppColors.primary,
    this.padding = const EdgeInsets.symmetric(
      vertical: 4.0,
      horizontal: 16.0,
    ),
  });
  final void Function()? onPressed;
  final String buttonText;
  final Color buttonColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(backgroundColor: buttonColor),
              child: Text(
                buttonText,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
