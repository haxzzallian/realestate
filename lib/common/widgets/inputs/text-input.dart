import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realestate/common/widgets/common/height-spacer.dart';
import 'package:realestate/theme/color.dart';
import 'package:realestate/theme/sizes.dart';
import 'package:realestate/theme/text-styles.dart';

class AppTextInput extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final String? prefixIcon;
  final String? suffixIcon;
  final int? maxlines;
  final Widget? suffixWidget;
  final FocusNode focusNode;
  final double height, width, borderRadius;
  final TextInputType textInputType;
  final Function(String)? validate;
  final Color fillColor;
  final bool isPassword, enable;
  final Function()? onTap;
  final Function()? onSuffixTap;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;

  const AppTextInput(
      {required this.controller,
      this.height = 54,
      this.onTap,
      this.onChanged,
      this.onEditingComplete,
      this.label,
      this.enable = true,
      this.maxlines = 1,
      required this.validate,
      this.fillColor = const Color(0xffF2F2F2),
      this.width = double.maxFinite,
      this.isPassword = false,
      this.borderRadius = 10,
      this.hint = "",
      this.textInputType = TextInputType.text,
      this.prefixIcon,
      Key? key,
      this.suffixIcon,
      this.onSuffixTap,
      required this.focusNode,
      this.suffixWidget})
      : super(key: key);

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  bool secure = false;
  Color borderColor = appPrimaryColor;
  Color iconColor = Colors.grey;
  Color backgroundColor = AppColor.separator1Light;

  @override
  Widget build(BuildContext context) {
    borderColor = widget.focusNode.hasFocus
        ? appPrimaryColor
        : widget.controller.text.isEmpty
            ? AppColor.separator2Color
            : appPrimaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Text(
                widget.label!,
                style: headerText3Style.copyWith(fontSize: ts4),
              )
            : Container(),
        const HeightSpacer(0.01),
        TextFormField(
          onEditingComplete: widget.onEditingComplete,
          onChanged: widget.onChanged,
          maxLines: widget.maxlines,
          onTap: widget.onTap,
          obscureText: secure,
          enabled: widget.enable,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          validator: (e) {
            return widget.validate == null ? null : widget.validate!(e!);
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
            hintText: widget.hint,
            hintStyle: bodyText2Style.copyWith(color: AppColor.hintTextColor),
            isDense: false,
            prefixIcon: widget.prefixIcon == null
                ? null
                : Transform.scale(
                    scale: 0.5,
                    child: SvgPicture.asset(
                      widget.prefixIcon!,
                      height: 10,
                      color: AppColor.hintTextColor,
                    ),
                  ),
            suffixIcon: widget.isPassword
                ? InkWell(
                    onTap: () {
                      setSecure();
                    },
                    child: icon())
                : widget.suffixIcon != null
                    ? InkWell(
                        onTap: widget.onSuffixTap,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 0, left: 0, top: 0),
                          child: SvgPicture.asset(
                            widget.suffixIcon!,
                            height: 10,
                            color: iconColor,
                            width: 10,
                          ),
                        ),
                      )
                    : widget.suffixWidget,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: appPrimaryColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 0.5),
            ),
            fillColor: backgroundColor,
            filled: true,
          ),
        ),
      ],
    );
  }

  setSecure() {
    setState(() {
      secure = !secure;
    });
  }

  Widget icon() {
    if (secure) {
      return const Icon(Icons.visibility_outlined);
    } else {
      return const Icon(Icons.visibility_off_outlined);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isPassword) {
      setState(() {
        secure = true;
      });
    }
  }
}
