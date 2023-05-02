import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NextButtonController {
  void startAnimation() {
    _isAnimating.value = true;
  }

  void stopAnimation() {
    _isAnimating.value = false;
  }

  final RxBool _isAnimating = false.obs;

  RxBool get isAnimating => _isAnimating;
}

class AnimatedNextButton extends StatelessWidget {
  const AnimatedNextButton({
    Key? key,
    this.onTap,
    this.color = const Color(0xffE72360),
    this.disableColor = const Color(0xffEAEAEA),
    this.animationCircleColor = Colors.white,
    this.iconData = Icons.arrow_forward_ios,
    required this.controller,
  }) : super(key: key);
  final NextButtonController controller;
  final Function()? onTap;
  final Color? color;
  final Color? disableColor;
  final Color animationCircleColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(100),
        color: onTap != null ? color : disableColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          // color: Colors.white,
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              // color: Color(0xffE72360),
            ),
            //  padding: const EdgeInsets.all(20), //12
            child: Center(
              child: Obx(
                () {
                  return Padding(
                    padding:
                        EdgeInsets.all(controller.isAnimating.value ? 15 : 20),
                    child: controller.isAnimating.value
                        ? SizedBox(
                            height: 34,
                            width: 34,
                            child: CircularProgressIndicator(
                              value: null,
                              strokeWidth: 4.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  animationCircleColor),
                            ),
                          )
                        : Icon(
                            iconData,
                            color: Colors.white,
                          ),
                  );
                },
              ),
            ),
          ),
        ));
  }
}

class NextButtonWidget extends StatefulWidget {
  const NextButtonWidget({Key? key}) : super(key: key);

  @override
  State<NextButtonWidget> createState() => _NextButtonWidgetState();
}

class _NextButtonWidgetState extends State<NextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
