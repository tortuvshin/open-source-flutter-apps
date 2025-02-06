import 'package:flutter/material.dart';

class MyAlign extends StatelessWidget {
  
  final AlignmentGeometry alignment;
  final double height;
  final double width;
  final Decoration decoration;
  
  const MyAlign({
    super.key,
    required this.alignment,
    required this.height,
    required this.width,
    required this.decoration
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        height: height,
        width: width,
        decoration: decoration,
      ),
    );
  }
}