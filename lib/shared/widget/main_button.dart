import 'package:flutter/material.dart';
import 'package:foxaac_app/styles/styles.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    this.isCancle = false,
  });

  final String text;
  final bool isCancle;

  static final AppStyle _style = AppStyle();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: _style.colors.primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            height: 50,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  color: isCancle ? Colors.black : Colors.white,
                  fontWeight: isCancle ? FontWeight.w300 : FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
