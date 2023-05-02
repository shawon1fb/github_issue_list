import 'package:flutter/material.dart';

import '../../../values/values.dart';
import 'spaces.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.title,
    this.onPressed,
//    this.width = Sizes.WIDTH_150,
    this.height = Sizes.HEIGHT_50,
    this.elevation = Sizes.ELEVATION_1,
    this.borderRadius = Sizes.RADIUS_24,
    this.color = AppColors.blackShade5,
    this.borderSide = Borders.defaultPrimaryBorder,
    this.textStyle,
    this.icon,
    this.hasIcon = false,
  }) : super(key: key);

  final VoidCallback? onPressed;

//  final double width;
  final double height;
  final double elevation;
  final double borderRadius;
  final String? title;
  final Color color;
  final BorderSide borderSide;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: elevation,
//      minWidth: width ?? MediaQuery.of(context).size.width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: borderSide,
      ),

      height: height,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon ?? Container(),
          (icon != null) ? const SpaceW8() : Container(),
          if (title != null)
            Text(
              title!,
              style: textStyle,
            )
          else
            Container(),
        ],
      ),
    );
  }
}
