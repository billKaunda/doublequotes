import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ShrinkableText extends StatelessWidget {
  const ShrinkableText(
    this.data, {
    this.style,
    this.textAlign = TextAlign.center,
    super.key,
  });

  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      data,
      style: style,
      textAlign: textAlign,
    );
  }
}
