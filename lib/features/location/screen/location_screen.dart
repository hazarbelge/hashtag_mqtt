import 'dart:ui' as ui;

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";
import 'package:hashtag_mqtt/core/theme/index.dart';
import 'package:hashtag_mqtt/core/utils/index.dart';
import 'package:hashtag_mqtt/features/location/index.dart';
import 'package:hashtag_mqtt/ui/widgets/custom_widgets/index.dart';

class HashTagScreen extends GetView<HashTagController> {
  const HashTagScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return CustomScaffold(
      key: const Key("location_screen_scaffold"),
      colors: const <Color>[
        ThemeColors.secondaryColor,
        ThemeColors.primaryColor,
      ],
      padding: EdgeInsets.symmetric(horizontal: _width * 0.09, vertical: _height * 0.05),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Expanded(
            flex: 2,
            child: Center(
              child: HashTagScreenLogo(),
            ),
          ),
          const Expanded(
            flex: 6,
            child: LocationShow(),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "your.location".tr,
              style: TextStyles.description.copyWith(
                fontSize: 24,
                color: ThemeColors.thirdColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class HashTagScreenLogo extends GetView<HashTagController> {
  const HashTagScreenLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(
          GlobalVariables.media.loadingIconPath,
        ),
        const SizedBox(height: 20),
        Text(
          "#HashTAG Location",
          style: TextStyles.descriptionBold.copyWith(
            fontSize: 24,
            color: ThemeColors.thirdColor,
          ),
        ),
      ],
    );
  }
}

class LocationShow extends StatelessWidget {
  const LocationShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      reverse: false,
      query: GlobalVariables.firebase.firebaseDatabaseRef,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      defaultChild: const SizedBox(),
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        debugPrint("data: ${snapshot.value}");

        if (snapshot.value == null) {
          return const SizedBox();
        }

        if (snapshot.value.runtimeType != <Object?, Object?>{}.runtimeType) {
          return const SizedBox();
        }

        final double? _x = (snapshot.value as Map<Object?, Object?>?)?["x"] as double?;
        final double? _y = (snapshot.value as Map<Object?, Object?>?)?["y"] as double?;
        final double? _z = (snapshot.value as Map<Object?, Object?>?)?["z"] as double?;

        return Point3DWidget(
          x: _x ?? 0,
          y: _y ?? 0,
          z: _z ?? 0,
        );
      },
    );
  }
}

class Point3DWidget extends StatelessWidget {
  const Point3DWidget({
    Key? key,
    required this.x,
    required this.y,
    required this.z,
  }) : super(key: key);

  final double x, y, z;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomPaint(
            size: const Size(400, 400),
            painter: PointPainter(
              x: x,
              y: y,
              z: z,
            ),
          ),
        ],
      ),
    );
  }
}

class PointPainter extends CustomPainter {
  PointPainter({
    required this.x,
    required this.y,
    required this.z,
  });

  final double x, y, z;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintCenter = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill;

    final Offset center = Offset(size.width / 2, size.height / 2);

    final Paint paintPoint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill;

    final Offset point = Offset(center.dx + x, center.dy - y);

    final Paint paintLine = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(center, point, paintLine);

    canvas.drawCircle(center, 5.0, paintCenter);

    canvas.drawCircle(point, 5.0, paintPoint);


    final ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: 14.0,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ));

    pb.pushStyle(ui.TextStyle(color: Colors.white));
    pb.addText('(${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)}, ${z.toStringAsFixed(2)})');
    const ui.ParagraphConstraints pc = ui.ParagraphConstraints(width: 200);
    final ui.Paragraph paragraph = pb.build()..layout(pc);
    canvas.drawParagraph(paragraph, point + const Offset(-100, 10));

    final ui.ParagraphBuilder pbCenter = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: 14.0,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ));

    pbCenter.pushStyle(ui.TextStyle(color: Colors.white));
    pbCenter.addText('(0.00, 0.00, 0.00)');
    const ui.ParagraphConstraints pcCenter = ui.ParagraphConstraints(width: 200);
    final ui.Paragraph paragraphCenter = pbCenter.build()..layout(pcCenter);
    canvas.drawParagraph(paragraphCenter, center + const Offset(-100, 10));
  }

  @override
  bool shouldRepaint(PointPainter old) {
    return old.x != x || old.y != y || old.z != z;
  }
}