import 'package:flutter/material.dart';
import 'dart:math';

enum AnimationType {
  fade,

  // flip
  flipX,
  flipXTop,
  flipXBottom,
  flipY,
  flipYLeft,
  flipYRight,

  // zoom
  zoom,
  zoomLeft,
  zoomRight,

  // rotate
  rotate,
  rotateLeft,
  rotateRight,

  // translate
  slide,
  shakeX,
  shakeY,
}

class AnimatedListItem extends StatefulWidget {
  final Widget child;

  /// the index of this item in List etc.
  final int index;

  /// amount of all these items
  final int length;

  final AnimationController aniController;

  /// If [animationType] is [AnimationType.slideIn], [startX] must not be null.
  /// [startX] only works when [animationType] is [AnimationType.slideIn].
  /// [startX] decide item starting point in x-axis
  final double startX;

  /// If [animationType] is [AnimationType.slideIn], [startY] must not be null.
  /// [startY] only works when [animationType] is [AnimationType.slideIn].
  /// [startY] decide item starting point in x-axis
  final double startY;

  ///  animation curves
  final Curve curve;

  /// use [animationType] to chose what Animation you want.
  final AnimationType animationType;

  /// use fade-in effect or not
  final bool fadeIn;

  const AnimatedListItem({
    Key? key,
    required this.child,
    required this.index,
    required this.length,
    required this.aniController,
    this.startX = 20,
    this.startY = 40,
    this.curve = Curves.linear,
    this.animationType = AnimationType.slide,
    this.fadeIn = true,
  }) : super(key: key);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with TickerProviderStateMixin {
  Animation<double> itemAnimation() {
    double delay = (widget.length - 1) / ((widget.length + 1) * widget.length);
    double start = delay * widget.index;
    double end = 1 - delay * (widget.length - widget.index - 1);

    return Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: widget.aniController,
      curve: Interval(
        start,
        end,
        curve: widget.curve,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animationType == AnimationType.fade) {
      return FadeTransition(
        opacity: itemAnimation(),
        child: widget.child,
      );
    }

    return AnimatedBuilder(
      animation: itemAnimation(),
      builder: (BuildContext context, child) {
        if (widget.fadeIn) {
          child = FadeTransition(
            opacity: itemAnimation(),
            child: child,
          );
        }

        switch (widget.animationType) {
          case AnimationType.flipX:
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.003)
                ..rotateX((1 - itemAnimation().value) * pi),
              child: child,
            );
          case AnimationType.flipXTop:
            return Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.003)
                ..rotateX((1 - itemAnimation().value) * pi),
              child: child,
            );
          case AnimationType.flipXBottom:
            return Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.003)
                ..rotateX((1 - itemAnimation().value) * pi),
              child: child,
            );
          case AnimationType.flipY:
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateY((1 - itemAnimation().value) * pi),
              child: child,
            );
          case AnimationType.flipYLeft:
            return Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateY((1 - itemAnimation().value) * pi),
              child: child,
            );
          case AnimationType.flipYRight:
            return Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateY((1 - itemAnimation().value) * pi),
              child: child,
            );
          case AnimationType.zoom:
            return Transform.scale(
              alignment: Alignment.center,
              scale: itemAnimation().value,
              child: child,
            );
          case AnimationType.zoomLeft:
            return Transform.scale(
              alignment: Alignment.centerLeft,
              scale: itemAnimation().value,
              child: child,
            );
          case AnimationType.zoomRight:
            return Transform.scale(
              alignment: Alignment.centerRight,
              scale: itemAnimation().value,
              child: child,
            );
          case AnimationType.rotate:
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateZ((1 - itemAnimation().value) * pi),
              child: child,
            );
          case AnimationType.rotateLeft:
            return Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.identity()
                ..rotateZ((1 - itemAnimation().value) * pi),
              child: child,
            );
          case AnimationType.rotateRight:
            return Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..rotateZ((1 - itemAnimation().value) * pi),
              child: child,
            );
          case AnimationType.slide:
            return Transform.translate(
              offset: Offset(
                itemAnimation().value * widget.startX - widget.startX,
                itemAnimation().value * widget.startY - widget.startY,
              ),
              child: child,
            );
          case AnimationType.shakeX:
            return Transform.translate(
              offset: Offset(
                sin(8 * pi * itemAnimation().value) * widget.startX,
                0,
              ),
              child: child,
            );
          case AnimationType.shakeY:
            return Transform.translate(
              offset: Offset(
                0,
                sin(8 * pi * itemAnimation().value) * widget.startY,
              ),
              child: child,
            );
          default:
            return child!;
        }
      },
      child: widget.child,
    );
  }
}
