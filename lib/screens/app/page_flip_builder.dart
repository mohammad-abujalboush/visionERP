import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';

typedef PageFlipBuilderCallback = Widget Function(BuildContext context);

class PageFlipBuilder extends StatefulWidget {
  final PageFlipBuilderCallback frontBuilder;
  final PageFlipBuilderCallback backBuilder;
  final Duration duration;

  const PageFlipBuilder({
    Key? key,
    required this.frontBuilder,
    required this.backBuilder,
    this.duration = const Duration(milliseconds: 600),
  }) : super(key: key);

  @override
  _PageFlipBuilderState createState() => _PageFlipBuilderState();
}

class _PageFlipBuilderState extends State<PageFlipBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showFrontSide = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: -1.0,
      upperBound: 1.0,
      value: 0.0,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        setState(() {
          _showFrontSide = !_showFrontSide;
          _controller.value = 0.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get isAnimationFirstHalf => _controller.value.abs() < 0.5;

  double getTilt() {
    final value = _controller.value;
    if (value < 0) {
      return lerpDouble(0, 0.003, value.abs() * 2)!;
    } else {
      return lerpDouble(0, -0.003, value.abs() * 2)!;
    }
  }

  double getRotationAngle() {
    final value = _controller.value;
    if (value < 0) {
      return lerpDouble(0, -pi, value.abs())!;
    } else {
      return lerpDouble(0, pi, value.abs())!;
    }
  }

  void handleDragUpdate(DragUpdateDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final delta = details.primaryDelta ?? 0;
    _controller.value += delta / screenWidth;
  }

  void handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed ||
        _controller.status == AnimationStatus.dismissed) {
      return;
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final flingVelocity = details.velocity.pixelsPerSecond.dx / screenWidth;

    if (_controller.value == 0.0 || flingVelocity == 0.0) {
      return;
    }

    const double flingThreshold = 2.0;

    if (_controller.value >= 0 && _controller.value < 0.5) {
      if (flingVelocity > flingThreshold) {
        _controller.fling(velocity: 2.0);
      } else {
        _controller.fling(velocity: -2.0);
      }
    } else if (_controller.value >= 0.5) {
      _controller.fling(velocity: 2.0);
    } else if (_controller.value < 0 && _controller.value > -0.5) {
      if (flingVelocity < -flingThreshold) {
        _controller.fling(velocity: -2.0);
      } else {
        _controller.fling(velocity: 2.0);
      }
    } else if (_controller.value <= -0.5) {
      _controller.fling(velocity: -2.0);
    }
  }

  void flip() {
    if (_controller.isAnimating) return;
    
    if (_controller.value == 0.0) {
      _controller.fling(velocity: 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: handleDragUpdate,
      onHorizontalDragEnd: handleDragEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final rotationAngle = getRotationAngle();
          final tilt = getTilt();

          final isFirstHalf = isAnimationFirstHalf;
          final showFront = isFirstHalf ^ _showFrontSide;

          final childToShow =
              showFront ? widget.frontBuilder(context) : widget.backBuilder(context);

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, tilt)
              ..rotateY(rotationAngle),
            child: childToShow,
          );
        },
      ),
    );
  }
}