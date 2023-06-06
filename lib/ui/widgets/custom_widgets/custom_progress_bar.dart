import 'package:flutter/material.dart';
import 'package:hashtag_mqtt/core/theme/index.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    Key? key,
    required this.title,
    required this.total,
    required this.current,
    this.progressColor = ThemeColors.primaryColor,
    this.containerColor = Colors.white,
    this.textColor = ThemeColors.primaryTextColor,
    this.borderRadius = 20,
  }) : super(key: key);

  final String title;
  final int total;
  final int current;
  final Color progressColor;
  final Color containerColor;
  final Color textColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "$title $current / $total",
          style: TextStyles.description.copyWith(
            fontSize: 14,
            color: textColor,
          ),
        ),
        const SizedBox(height: 15),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double _containerWidth = constraints.maxWidth;
            return Container(
              height: 15,
              width: _containerWidth,
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 15,
                    width: _containerWidth * (current / total),
                    decoration: BoxDecoration(
                      color: progressColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
