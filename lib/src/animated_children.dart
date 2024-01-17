import 'package:flutter/material.dart';

class AnimatedChildren extends StatelessWidget {
  final Animation<double> animation;
  final List<Widget> children;
  final Future Function() close;
  final bool invokeAfterClosing;

  const AnimatedChildren({
    Key? key,
    required this.animation,
    required this.children,
    required this.close,
    required this.invokeAfterClosing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: animation,
        builder: (context, _) => Column(
          children: List.generate(children.length, (i) => i).map((i) {
            final speedDialChild = children[i];
            final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Interval(
                    ((children.length - 1 - i) / children.length), 1,
                    curve: Curves.easeInOutCubic));

            onPressed() async {
              invokeAfterClosing ? await close() : close();
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onPressed,
                child: Row(
                  children: [
                    ScaleTransition(
                      scale: curvedAnimation,
                      child: speedDialChild,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      );
}
