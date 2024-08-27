import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors.dart';
import '../../theme/text_styles.dart';

class FilledRectButton extends StatefulWidget {
  const FilledRectButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor = AppColors.primary,
  });
  final void Function()? onPressed;
  final String buttonText;
  final Color buttonColor;

  @override
  State<FilledRectButton> createState() => _FilledRectButtonState();
}

class _FilledRectButtonState extends State<FilledRectButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(widget.buttonColor),
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        // fixedSize: MaterialStatePropertyAll(Size(700, 36)),
      ),
      child: Text(
        widget.buttonText,
        style: AppTS.white18TS.copyWith(fontSize: 14.sp),
      ),
    );
  }
}
