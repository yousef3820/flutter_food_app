import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  final FontWeight weight;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.size = 16,
    this.weight = FontWeight.normal,
    this.align,
    this.maxLines,
    this.overflow,
  });
  
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color ?? Theme.of(context).colorScheme.onBackground,
        fontSize: size,
        fontWeight: weight,
        fontFamily: "Roboto",
      ),
    );
  }
}