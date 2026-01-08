import 'package:flutter/material.dart';

class CheckoutDetailsText extends StatelessWidget {
  const CheckoutDetailsText({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
  });
  final String title;
  final String value;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11,horizontal: 10),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
