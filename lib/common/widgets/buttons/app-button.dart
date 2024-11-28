import 'package:flutter/material.dart';
import 'package:realestate/theme/color.dart';
import 'package:realestate/theme/sizes.dart';
import 'package:realestate/theme/text-styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color? enabledBtnColor;
  final Color? disabledBtnColor;
  final Color? textColor;
  final bool? enabled;
  final double? paddingVertical;
  final bool? smallButton;
  final Function() onTap;
  const AppButton(
      {super.key,
      required this.text,
      this.enabledBtnColor,
      this.textColor,
      this.enabled,
      required this.onTap,
      this.disabledBtnColor,
      this.paddingVertical,
      this.smallButton = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled == null
          ? onTap
          : enabled!
              ? onTap
              : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: enabled == null
                  ? enabledBtnColor ?? appPrimaryColor
                  : enabled!
                      ? enabledBtnColor ?? appPrimaryColor
                      : disabledBtnColor ?? appTertiaryColor,
              width: 1),
          color: enabled == null
              ? enabledBtnColor ?? appPrimaryColor
              : enabled!
                  ? enabledBtnColor ?? appPrimaryColor
                  : disabledBtnColor ?? appTertiaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: paddingVertical ?? 15.0),
          child: Center(
            child: Text(text,
                style: bodyText2Style.copyWith(
                    color: enabled != null
                        ? enabled!
                            ? textColor ?? Colors.white
                            : Colors.black
                        : textColor ?? Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: ts3)),
          ),
        ),
      ),
    );
  }
}
