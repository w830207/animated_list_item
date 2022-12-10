import 'package:flutter/material.dart';
import 'dart:math';

enum AnimationType {
  flipX,
  flipY,
  zoomIn,
  slideIn,
}

class AnimatedListItem extends StatefulWidget {
  final Widget child;

  /// the index of this item in List etc.
  final int index;

  /// amount of all these items
  final int length;

  ///
  final AnimationController aniController;

  /// If [animationType] is [AnimationType.slideIn], [startX] must not be null.
  /// [startX] only works when [animationType] is [AnimationType.slideIn].
  /// [startX] decide item starting point in x-axis
  final double? startX;

  /// If [animationType] is [AnimationType.slideIn], [startY] must not be null.
  /// [startY] only works when [animationType] is [AnimationType.slideIn].
  /// [startY] decide item starting point in x-axis
  final double? startY;

  ///  animation curves
  final Curve curve;

  /// use [animationType] to chose what Animation you want.
  final AnimationType animationType;

  const AnimatedListItem({
    Key? key,
    required this.child,
    required this.index,
    required this.length,
    required this.aniController,
    this.startX,
    this.startY,
    this.curve = Curves.linear,
    this.animationType = AnimationType.slideIn,
  })  : assert(
            animationType == AnimationType.slideIn
                ? startX == null
                    ? false
                    : true
                : true,
            "If animationType is AnimationType.slide, startX must not be null."),
        assert(
            animationType == AnimationType.slideIn
                ? startY == null
                    ? false
                    : true
                : true,
            "If animationType is AnimationType.slide, startY must not be null."),
        super(key: key);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with TickerProviderStateMixin {
  itemAnimation() {
    double delay = (widget.length - 1) / ((widget.length + 1) * widget.length);
    double start = delay * widget.index;
    double end = 1 - delay * (widget.length - widget.index - 1);

    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: widget.aniController,
        curve: Interval(
          start,
          end,
          curve: widget.curve,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: itemAnimation(),
      builder: (BuildContext context, child) {
        child = FadeTransition(
          opacity: itemAnimation(),
          child: child,
        );

        switch (widget.animationType) {
          case AnimationType.flipX:
            return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateX((1 - itemAnimation().value) * pi),
                child: child);
          case AnimationType.flipY:
            return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002)
                  ..rotateY((1 - itemAnimation().value) * pi),
                child: child);
          case AnimationType.zoomIn:
            return Transform.scale(
                alignment: Alignment.center,
                scale: itemAnimation().value,
                child: child);
          case AnimationType.slideIn:
            return Transform.translate(
              offset: Offset(
                  itemAnimation().value * widget.startX - widget.startX,
                  itemAnimation().value * widget.startY - widget.startY),
              child: child,
            );
        }
      },
      child: widget.child,
    );
  }
}
