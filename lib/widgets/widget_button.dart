// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:realpost/utility/app_constant.dart';
import 'package:realpost/widgets/widget_text.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.width,
    this.bgColor,
    this.textColor,
    this.circular,
    this.labelStyle,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;
  final double? width;
  final Color? bgColor;
  final Color? textColor;
  final double? circular;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(circular ?? 10)),
          ),
          onPressed: pressFunc,
          child: WidgetText(
            text: label,
            textStyle: labelStyle ?? AppConstant().h2Style(color: textColor),
          )),
    );
  }
}
