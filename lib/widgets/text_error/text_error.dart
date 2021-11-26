import 'package:flutter/material.dart';

import 'package:stream/theme/palette.dart';

// ignore: must_be_immutable
class TextErrorWidget extends StatelessWidget {
  TextErrorWidget({
    required this.text,
    this.size = 14.0,
  });

  late Palette palette;

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText2!.merge(
                  TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                    fontSize: size,
                  ),
                ),
          ),
        ),
        const SizedBox(width: 14.0),
        const Padding(
          padding: EdgeInsets.only(top: 1.0),
          child: Icon(
            Icons.error_outlined,
            color: Colors.red,
            size: 16,
          ),
        ),
      ],
    );
  }
}
