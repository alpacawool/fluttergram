import 'package:flutter/material.dart';

class FlexText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int flexValue;

  const FlexText({
    Key key, 
    this.text, 
    this.style, 
    this.flexValue}) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flexValue,
      child: Text(
        text,
        style: style
      )
    );
  }
}
