import 'package:flutter/material.dart';
import 'package:hashtag_mqtt/core/theme/index.dart';
import 'package:hashtag_mqtt/ui/widgets/base_widgets/base_button.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.backgroundColor = ThemeColors.primaryColor,
    this.foregroundColor = Colors.transparent,
    this.overlayColor = Colors.transparent,
    this.shadowColor = Colors.transparent,
    this.surfaceTintColor = Colors.transparent,
    this.textColor = Colors.white,
    this.text,
    this.fontSize,
    this.fontWeight = FontWeight.w500,
    this.borderRadius = 31,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1,
    this.elevation = 2,
    this.shape,
    this.paddings = const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    this.child,
    this.prefix,
    this.suffix,
    this.textStyle,
    this.textAlign = TextAlign.center,
    this.height = 65,
  }) : super(key: key);

  final Color backgroundColor;
  final Color foregroundColor;
  final Color overlayColor;
  final Color shadowColor;
  final Color surfaceTintColor;
  final Color textColor;
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double borderRadius;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final Color borderColor;
  final double borderWidth;
  final double elevation;
  final EdgeInsets paddings;
  final MaterialStateProperty<OutlinedBorder?>? shape;
  final Widget? child;
  final Widget? prefix;
  final Widget? suffix;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      color: Colors.transparent,
      clipBehavior: Clip.none,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        color: Colors.transparent,
        clipBehavior: Clip.none,
        child: BaseButton(
          textColor: textColor,
          focusNode: focusNode,
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((Set<MaterialState> states) => elevation),
            backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => backgroundColor),
            foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => foregroundColor),
            overlayColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => overlayColor),
            shadowColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => shadowColor),
            surfaceTintColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => surfaceTintColor),
            shape: shape ??
                MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) => RoundedRectangleBorder(
                    side: BorderSide(
                      color: borderColor,
                      width: borderWidth,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
            padding: MaterialStateProperty.resolveWith((Set<MaterialState> states) => paddings),
          ),
          child: child ??
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  prefix ?? const SizedBox(),
                  const Spacer(),
                  Expanded(
                    flex: 10,
                    child: Text(
                      text ?? "",
                      style: textStyle ??
                          TextStyle(
                            color: textColor,
                            fontWeight: fontWeight,
                            fontSize: fontSize,
                          ),
                      textAlign: textAlign,
                    ),
                  ),
                  const Spacer(),
                  suffix ?? const SizedBox(),
                ],
              ),
        ),
      ),
    );
  }
}
