import 'package:flutter/material.dart';

class HeatMap extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> scaleAnimation;
  final Animation<double> fadeTextAnimation;

  const HeatMap({
    required this.animationController,
    required this.scaleAnimation,
    required this.fadeTextAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 100,
      top: 150,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: scaleAnimation.value,
            child: Opacity(
              opacity: fadeTextAnimation.value,
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  "11 mn p",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
