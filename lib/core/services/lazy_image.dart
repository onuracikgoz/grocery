import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sigma_assigment/core/const/Icon_constant.dart';
import 'package:sigma_assigment/core/services/icon_widget.dart';

import 'package:simple_animations/stateless_animation/play_animation.dart';

class LazyImage extends StatelessWidget {
  LazyImage(
      {this.url,
       this.width,
       this.height,
      required this.fit,
      this.circle = false});

  final String? url;

  final double? width;
  final double? height;
  final BoxFit fit;
  final bool circle;

  Widget build(BuildContext context) {
    if (circle) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10000.0),
        child: CachedNetworkImage(
          imageUrl: url!,
          width: width,
          height: height,
          fit: fit,
          errorWidget: (context, text, data) {
            return CustomIconWidget(iconPath: IconConstant.instance.logo);
          },
          placeholder: (context, url) => Container(
            color: Colors.black.withOpacity(.05),
            width: width,
            height: height,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Icon(
                    Icons.image,
                    // size: width / 10,
                    size: 50,
                    color: Colors.black.withOpacity(.1),
                  ),
                ),
                onBottom(AnimatedWave(
                  height: 180,
                  speed: 1.0,
                )),
                onBottom(AnimatedWave(
                  height: 120,
                  speed: 0.9,
                  offset: pi,
                )),
                onBottom(AnimatedWave(
                  height: 220,
                  speed: 1.2,
                  offset: pi / 2,
                )),
              ],
            ),
          ),
        ),
      );
    } else {
      return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
        child: CachedNetworkImage(
          imageUrl: url!,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => Container(
            color: Colors.black.withOpacity(.05),
            width: width,
            height: height,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Icon(
                    Icons.image,
                    // size: width / 10,
                    size: 50,
                    color: Colors.black.withOpacity(.1),
                  ),
                ),
                onBottom(AnimatedWave(
                  height: 180,
                  speed: 1.0,
                )),
                onBottom(AnimatedWave(
                  height: 120,
                  speed: 0.9,
                  offset: pi,
                )),
                onBottom(AnimatedWave(
                  height: 220,
                  speed: 1.2,
                  offset: pi / 2,
                )),
              ],
            ),
          ),
          errorWidget: (context, text, data) {
            return CustomIconWidget(iconPath: IconConstant.instance.logo);
          },
        ),
      );
    }
  }

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  AnimatedWave({required this.height, required this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: PlayAnimation<double>(
            duration: Duration(milliseconds: (1500 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, child, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
