import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/widgets/app_scaffold/app_scaffold.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.helloWorld,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}