import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color color;
  final Alignment alignment;
  final int? maxLine;
  final double height;
  final Function()? onTap;

  CustomText({
    this.text = '',
    this.fontSize = 16,
    this.color = Colors.black,
    this.alignment = Alignment.topLeft,
    this.maxLine,
    this.height = 1,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        alignment: alignment,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            height: height,
            fontSize: fontSize,
          ),
          maxLines: maxLine,
        ),
      ),
    );
  }
}