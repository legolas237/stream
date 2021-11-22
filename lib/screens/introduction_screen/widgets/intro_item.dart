import 'package:flutter/material.dart';

import 'package:stream/theme/palette.dart';

// ignore: must_be_immutable
class IntroItemWidget extends StatelessWidget {
  IntroItemWidget({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  late Palette palette;

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline1!.merge(
            const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
            ),
          )
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
        Padding(
         padding: EdgeInsets.symmetric(
           horizontal: MediaQuery.of(context).size.width * 0.14,
         ),
         child: Text(
             subTitle,
             textAlign: TextAlign.center,
             style: Theme.of(context).textTheme.caption!.merge(
               const TextStyle(
                 fontSize: 12.0,
                 fontWeight: FontWeight.w400,
               ),
             )
         ),
       ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
