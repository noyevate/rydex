import 'package:flutter/material.dart';

class ReuseableText extends StatelessWidget {
  final String title;
  final TextStyle style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final bool? softWrap;

  const ReuseableText({
    super.key,
    required this.title,
    required this.style,
    this.textAlign,
    this.overflow, this.decoration, this.softWrap
    
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style.copyWith(
        fontFamily: style.fontFamily ?? 'Metropolis',
        decoration: decoration ?? TextDecoration.none  // Default to 'Aeonik' if not provided
      ) ,
      textAlign: textAlign ?? TextAlign.left,
      
      overflow: overflow ?? TextOverflow.ellipsis,
      softWrap: softWrap ?? false,
    );
  }
}
