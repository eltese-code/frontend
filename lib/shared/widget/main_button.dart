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
    return Expanded(
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            backgroundColor:
                isCancle ? const Color(0xffD9D9D9) : _style.colors.primaryColor,
          ),
          onPressed: () {},
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
    );
  }
}
