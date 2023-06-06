import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashtag_mqtt/core/theme/index.dart';

class BottomSheetDialog extends StatelessWidget {
  const BottomSheetDialog({
    Key? key,
    required this.child,
    this.upChild,
    this.padding,
  }) : super(key: key);

  final Widget child;
  final Widget? upChild;
  final EdgeInsets? padding;

  static Future<dynamic> openBottomSheetDialog({
    required Widget child,
    Widget? upChild,
    EdgeInsets? padding,
  }) async {
    return showDialog(
      context: Get.overlayContext ?? Get.context!,
      barrierDismissible: true,
      useSafeArea: false,
      builder: (_) => BottomSheetDialog(
        child: child,
        upChild: upChild,
        padding: padding,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: _width * 0.05, vertical: _height * 0.025),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          Material(
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                if (upChild != null)
                  Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: upChild,
                  ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
