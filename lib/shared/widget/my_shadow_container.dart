import 'package:flutter/material.dart';

class MyShadowContainer extends Container {
  MyShadowContainer({
    super.key,
    required this.childWidget,
  });

  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: childWidget,
    );
  }
}
