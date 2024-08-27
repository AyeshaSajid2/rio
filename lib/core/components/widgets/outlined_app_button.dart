import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import 'package:flutter_svg/svg.dart';

class OutlinedAppButton extends StatelessWidget {
  const OutlinedAppButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor = AppColors.primary,
    this.padding = const EdgeInsets.symmetric(
      vertical: 4.0,
      horizontal: 16.0,
    ),
    this.svgPath,
    this.svgColor = AppColors.white,
  });
  const OutlinedAppButton.icon({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor = AppColors.primary,
    this.padding = const EdgeInsets.symmetric(
      vertical: 4.0,
      horizontal: 16.0,
    ),
    required this.svgPath,
    this.svgColor = AppColors.white,
  });
  final void Function()? onPressed;
  final String buttonText;
  final Color buttonColor;
  final EdgeInsetsGeometry padding;
  final String? svgPath;
  final Color? svgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                    StadiumBorder(side: BorderSide(color: buttonColor))),
                side: MaterialStatePropertyAll(BorderSide(color: buttonColor)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (svgPath != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        svgPath!,
                        colorFilter:
                            ColorFilter.mode(svgColor!, BlendMode.srcIn),
                      ),
                    ),
                  Text(
                    buttonText,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: buttonColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
