import 'package:flutter/material.dart';

class CircularSizedAvatarWidget extends StatelessWidget {
  const CircularSizedAvatarWidget({
    required this.size,
    required this.backgroundImage,
    this.backgroundColor = Colors.transparent,
    this.callback,
  });

  final double size;
  final ImageProvider backgroundImage;
  final Color backgroundColor;
  final Function? callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: size,
        height: size,
        child: CircleAvatar(
          radius: size,
          backgroundImage: backgroundImage,
          backgroundColor: backgroundColor,
        ),
      ),
      onTap: () {
        if (callback != null) {
          callback!();
        }
      },
    );
  }
}
