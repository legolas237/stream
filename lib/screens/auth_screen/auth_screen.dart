import 'package:flutter/material.dart';

import 'package:stream/screens/login_screen/login_screen.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  AuthScreen({Key? key}) : super(key: key);

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late int _currentTab;

  @override
  void initState() {
    super.initState();

    _currentTab = 1;
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    return _buildTree();
  }

  // Renders

  Widget _buildTree() {
    if(_currentTab == 1) {
      return LoginScreen();
    }

    return const SizedBox();
  }
}