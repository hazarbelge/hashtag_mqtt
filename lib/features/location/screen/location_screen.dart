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
    final Size screenSize = MediaQuery.of(context).size;
    final double maxCircleRadius = screenSize.width / 2;

    return FirebaseAnimatedList(
      reverse: false,
      query: GlobalVariables.firebase.firebaseDatabaseRef,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      defaultChild: const SizedBox(),
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        debugPrint("distance: ${snapshot.value} m");

        if (snapshot.value == null) {
          return const SizedBox();
        }

        final double? _distance = double.tryParse(snapshot.value!.toString());

        final double centerSize = maxCircleRadius * 1.5 * (1 - (_distance ?? 0) * 40 / maxCircleRadius);
        double effectiveCenterSize = centerSize > 5 ? centerSize : 5;

        if (_distance! <= 0.1) {
          effectiveCenterSize = maxCircleRadius * 2;
        }

        return SizedBox(
          height: maxCircleRadius * 2,
          width: maxCircleRadius * 2,
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  height: maxCircleRadius * 2,
                  width: maxCircleRadius * 2,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[
                        ThemeColors.secondaryColor,
                        ThemeColors.primaryColor,
                      ],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
              ),
              Center(
                child: CustomPaint(
                  painter: LinePainter(maxCircleRadius, _distance),
                ),
              ),
              Center(
                child: Container(
                  height: effectiveCenterSize,
                  width: effectiveCenterSize,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "Anchor Point",
                      style: TextStyles.descriptionBold.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
              ),
              if (_distance > 0.1)
                Center(
                  child: CustomPaint(
                    painter: DistancePainter(maxCircleRadius, _distance),
                  ),
                ),
              if (_distance <= 0.1)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "${"almost.same.position".tr}\n$_distance m",
                      style: TextStyles.descriptionBold.copyWith(
                        fontSize: 24,
                        color: ThemeColors.thirdColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class DistancePainter extends CustomPainter {
  DistancePainter(this.radius, this.distance);

  final double radius;
  final double distance;

  @override
  void paint(Canvas canvas, Size size) {
    final TextSpan textSpan = TextSpan(
      text: '$distance m',
      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );

    final TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout();

    final Offset offset = Offset(
      -radius * 0.18 + radius - textPainter.width,
      size.height / 2 - textPainter.height / 2 - 10,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LinePainter extends CustomPainter {
  LinePainter(this.radius, this.distance);

  final double radius;
  final double distance;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw line horizontally from center to edge of circle
    canvas.drawLine(
      Offset(size.width / 2, size.height / 2),
      Offset(-radius * 0.18 + radius, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
