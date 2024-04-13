import 'package:flutter/material.dart';

class AnimationButton extends StatefulWidget {
  const AnimationButton({
    super.key,
    required this.child,
    required this.onTap,
    this.isDone = false,
    this.upperBound = 0.1,
  });

  final Widget child;
  final void Function() onTap;
  final bool isDone;
  final double upperBound;

  @override
  State<AnimationButton> createState() => _AnimationButtonState();
}

class _AnimationButtonState extends State<AnimationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double _scale = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: widget.upperBound,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown() {
    _controller.forward();
  }

  void _onTapUp() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 + _controller.value;
    return GestureDetector(
      onTap: () {
        tapAnimation();
        widget.onTap();
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }

  void tapAnimation() async {
    _onTapDown();
    await Future.delayed(const Duration(milliseconds: 200))
        .then((_) => _onTapUp());
    if (widget.isDone) await Future.delayed(const Duration(milliseconds: 500));
  }
}
