import 'package:flutter/material.dart';
import 'package:foxaac_app/styles/styles.dart';

class BookStateButton extends StatelessWidget {
  const BookStateButton({
    super.key,
    required this.text,
    this.isActive = false,
  });

  final String text;
  final bool isActive;

  static final AppStyle _style = AppStyle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 100,
      decoration: BoxDecoration(
        color: isActive ? _style.colors.grey2 : Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(color: _style.colors.grey2),
      ),
      child: Center(child: Text(text)),
    );
  }
}
