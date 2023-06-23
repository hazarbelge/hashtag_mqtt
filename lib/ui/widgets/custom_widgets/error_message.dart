import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    Key? key,
    required this.message,
    required this.notifier,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
  }) : super(key: key);

  final String message;
  final ValueNotifier<bool> notifier;
  final Color textColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (BuildContext context, bool value, Widget? child) {
        if (!value) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/app/error.svg",
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  iconColor,
                  BlendMode.srcIn,
                )
              ),
              const SizedBox(width: 10),
              Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
