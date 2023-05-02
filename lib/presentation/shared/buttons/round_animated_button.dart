import 'package:flutter/material.dart';

class AnimationButtonController {
  final AnimationController _btController;

  AnimationButtonController(AnimationController loginButtonController)
      : _btController = loginButtonController;

  void dispose() {
    _btController.dispose();
  }

  AnimationController get btController => _btController;

  Future<void> playAnimation() async {
    try {
      // setState(() {
      //   isLoading = true;
      // });
      await _btController.forward();
    } on TickerCanceled {
      debugPrint('[_playAnimation] error');
    }
  }

  Future<void> stopAnimation() async {
    try {
      await _btController.reverse();
      // setState(() {
      //   isLoading = false;
      // });
    } on TickerCanceled {
      debugPrint('[_stopAnimation] error');
    }
  }
}

class RoundAnimationButton extends StatelessWidget {
  final VoidCallback? onTap;
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

  RoundAnimationButton({
    Key? key,
    required this.buttonController,
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
  })  : buttonSqueezeAnimation = Tween(
          begin: width,
          end: 50.0,
        ).animate(
          CurvedAnimation(
            parent: buttonController.view,
            curve: const Interval(
              0.0,
              0.150,
            ),
          ),
        ),
        containerCircleAnimation = EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 30.0),
          end: const EdgeInsets.only(bottom: 0.0),
        ).animate(
          CurvedAnimation(
            parent: buttonController.view,
            curve: const Interval(
              0.500,
              0.800,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController buttonController;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttonSqueezeAnimation;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    //final theme = Theme.of(context);
    //  final mSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSqueezeAnimation.value,
        height: 50,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: backgroundColor, // ?? Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: buttonSqueezeAnimation.value > width - 10 //(width/2.0)//75.0
            ? Wrap(
                // crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) icon!,
                  if (icon != null)
                    const SizedBox(
                      width: 10,
                    ),
                  Text(
                    text,
                    style: textStyle ??
                        TextStyle(
                          color: textColor,
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                        ),
                  ),
                ],
              )
            : CircularProgressIndicator(
                value: null,
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(animationCircleColor),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController.view,
    );
  }
}
