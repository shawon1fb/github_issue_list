import 'package:flutter/material.dart';

import 'round_animated_button.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    Key? key,
    this.onTap,
    this.fontWeight = FontWeight.w600,
    this.icon,
    this.animationCircleColor = Colors.white,
    this.textColor = Colors.black,
    this.text = 'SIGN IN',
    this.textStyle,
    this.width = 320,
    this.fontSize = 14,
    this.borderRadius = 25.0,
    this.backgroundColor = const Color(0xff73D1F1),
    this.preAnimationCallback,
  }) : super(key: key);

  final VoidCallback? onTap;
  final VoidCallback? preAnimationCallback;
  final String text;
  final double width;
  final double borderRadius;
  final Color backgroundColor;
  final Widget? icon;
  final TextStyle? textStyle;
  final double fontSize;
  final Color textColor;
  final Color animationCircleColor;
  final FontWeight fontWeight;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  late AnimationButtonController animationButtonController;

  @override
  void initState() {
    animationButtonController = AnimationButtonController(
      AnimationController(
        duration: const Duration(milliseconds: 3000),
        vsync: this,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    animationButtonController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoundAnimationButton(
      buttonController: animationButtonController.btController,
      onTap: () async {
        widget.preAnimationCallback?.call();
        await animationButtonController.playAnimation();
        widget.onTap?.call();
        await animationButtonController.stopAnimation();
      },
      fontWeight: widget.fontWeight,
      icon: widget.icon,
      animationCircleColor: widget.animationCircleColor,
      textColor: widget.textColor,
      text: widget.text,
      textStyle: widget.textStyle,
      width: widget.width,
      fontSize: widget.fontSize,
      borderRadius: widget.borderRadius,
      backgroundColor: widget.backgroundColor,
    );
  }
}
