import 'package:flutter/material.dart';
import 'dart:math';

enum AnimationType {
  slide,
  flip,
  zoom,
}

class AnimatedListItem extends StatefulWidget {
  final Widget child;
  final int index;
  final int length;
  final AnimationController aniController;
  final double? startX;
  final double? startY;
  final Curve curve;
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
    this.animationType = AnimationType.slide,
  })  : assert(
            animationType == AnimationType.slide
                ? startX == null
                    ? false
                    : true
                : true,
            "AnimationType.slide startX 必填"),
        assert(
            animationType == AnimationType.slide
                ? startY == null
                    ? false
                    : true
                : true,
            "AnimationType.slide startY 必填"),
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
          case AnimationType.slide:
            return Transform.translate(
              offset: Offset(
                  itemAnimation().value * widget.startX - widget.startX,
                  itemAnimation().value * widget.startY - widget.startY),
              child: child,
            );
          case AnimationType.flip:
            return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002)
                  ..rotateY((1 - itemAnimation().value) * pi),
                child: child);
          case AnimationType.zoom:
            return Transform.scale(
                alignment: Alignment.center,
                scale: itemAnimation().value,
                child: child);
        }
      },
      child: widget.child,
    );
  }
}
