// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../theme/colors.dart';
import '../../utils/helpers/common_func.dart';

// class FilledRoundedPinPut extends StatefulWidget {
//   const FilledRoundedPinPut({Key? key}) : super(key: key);

//   @override
//   _FilledRoundedPinPutState createState() => _FilledRoundedPinPutState();

//   @override
//   String toStringShort() => 'Rounded Filled';
// }

class FilledRoundedPinPut extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const FilledRoundedPinPut({
    super.key,
    required this.controller,
    required this.validator,
  });

  // @override
  // void dispose() {
  //   controller.dispose();
  //   focusNode.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    const length = 6;
    const borderColor = AppColors.primary;
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = AppColors.primary;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontFamily: 'CircularStd',
// font-style: normal;
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: AppColors.appBlack,
      ),
      decoration: BoxDecoration(
        // color: fillColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
    );

    return SizedBox(
      // height: 68,
      child: Pinput(
        length: length,
        controller: controller,
        // focusNode: FocusNode(),
        defaultPinTheme: defaultPinTheme,
        validator: validator,
        onTapOutside: (event) {
          constants.hideKeyboard(context);
        },
        onCompleted: (pin) {
          // setState(() => showError = pin != '555555');

          constants.hideKeyboard(context);
        },
        onSubmitted: (value) {
          constants.hideKeyboard(context);
        },
        focusedPinTheme: defaultPinTheme.copyWith(
          // height: 68,
          // width: 64,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: borderColor),
            color: fillColor.withOpacity(0.1),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: errorColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
