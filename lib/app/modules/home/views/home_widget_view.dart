import 'package:flutter/material.dart';

class StatDisplay extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  const StatDisplay({
    required this.label,
    required this.value,
    this.labelStyle = const TextStyle(fontSize:15, fontWeight: FontWeight.bold),
    this.valueStyle = const TextStyle(fontSize:15, fontWeight: FontWeight.w500),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
      
          Text(
            label,
            style: labelStyle,
          ),
          Text(
            value,
            style: valueStyle,
          ),
        ],
      ),
    );
  }
}
