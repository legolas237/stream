import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/screens/profile_screen/profile_screen.dart';
import 'package:stream/screens/tabs_screen/widgets/bottom_tab.dart';
import 'package:stream/screens/tabs_screen/widgets/bottom_tab_item.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';

  TabsScreen({Key? key}) : super(key: key);

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  static const homeScreen = "home";
  static const settingScreen = "setting";
  static const profileScreen = "profile";
  static const discoverScreen = "discover";
  static const subscriptionScreen = "subscription";

  late String _selectedScreen;

  @override
  void initState() {
    super.initState();

    _selectedScreen = homeScreen;
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    List<Map<String, dynamic>> _items = _tabs();
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: widget.palette.scaffoldColor(1.0),
          child: _getCurrentScreen(),
        ),
        Positioned(
          bottom: 0,
          child: _renderBottomNavigationBar(),
        ),
      ],
    );
  }

  // Render

  Widget _renderBottomNavigationBar() {
    List<Map<String, dynamic>> _items = _tabs();
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return BottomTabWidget(
      items: _items.asMap().entries.map((entry) {
        return BottomTabItemWidget(
          icon: entry.value["icon"],
          selected: _selectedScreen == entry.value["screen"],
          width: (mediaQuery.size.width / _items.length) - 10,
          callback: () => _selectScreen(entry.value["screen"]),
        );
      }).toList().cast<BottomTabItemWidget>(),
    );
  }

  List<Map<String, Object>> _tabs() {
    return [
      {
        "icon": Icons.widgets,
        "screen": homeScreen,
      },
      {
        "icon": Icons.explore_outlined,
        "screen": discoverScreen,
      },
      {
        "icon": Icons.subscriptions_outlined,
        "screen": subscriptionScreen,
      },
      {
        "icon": Icons.settings_outlined,
        "screen": settingScreen,
      },
      {
        "icon": Icons.face_outlined,
        "screen": profileScreen,
      },
    ];
  }

  Widget _getCurrentScreen() {
    switch (_selectedScreen) {
      case homeScreen:
        return Container();
      case discoverScreen:
        return Container();
      case subscriptionScreen:
        return Container();
      case profileScreen:
        return ProfileScreen();
      case settingScreen:
        return Container();
      default:
        return Container();
    }
  }

  void _selectScreen(String page) {
    setState(() {
      _selectedScreen = page;
    });
  }
}