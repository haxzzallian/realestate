import 'package:flutter/material.dart';
import 'package:realestate/theme/color.dart';
import 'package:pinput/pinput.dart';

class PinInput extends StatefulWidget {
  final TextEditingController pinController;
  final FocusNode pinFocus;
  final Function(String)? validate;
  final Function(String)? onCompleted;
  final Function(String)? onChanged;
  const PinInput(
      {this.validate,
      required this.pinController,
      required this.pinFocus,
      this.onCompleted,
      this.onChanged,
      super.key});

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  @override
  Widget build(BuildContext context) {
    return Pinput(
      onChanged: widget.onChanged,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      closeKeyboardWhenCompleted: true,
      controller: widget.pinController,
      focusNode: widget.pinFocus,
      length: 5,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: focusedPinTheme,
      defaultPinTheme: defaultPinTheme,
      onCompleted: widget.onCompleted,
      validator: (e) {
        return widget.validate == null ? null : widget.validate!(e!);
      },
      obscureText: true,
      obscuringWidget: Container(
        height: 10,
        width: 10,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
      ),
    );
  }

  final defaultPinTheme = PinTheme(
    width: 65,
    height: 65,
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.borderSeparator2Color),
        color: AppColor.separator1Light),
  );

  final focusedPinTheme = PinTheme(
    width: 65,
    height: 65,
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: appPrimaryColor),
        color: AppColor.separator1Light),
  );
}
