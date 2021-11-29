import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/config/config.dart';
import 'package:stream/screens/auth_screen/auth_screen.dart';
import 'package:stream/screens/introduction_screen/widgets/intro_item.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';
import 'package:stream/widgets/border_wrapper/border_wrapper.dart';
import 'package:stream/widgets/button/button.dart';

// ignore: must_be_immutable
class IntroScreen extends StatefulWidget {
  static const routeName = '/intro';

  IntroScreen({Key? key}) : super(key: key);

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late int screenLength;
  late int currentIndexScreen;
  late CarouselController _buttonCarouselController;

  @override
  void initState() {
    super.initState();

    screenLength = 3;
    currentIndexScreen = 0;
    _buttonCarouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    return ScaffoldWidget(
      backgroundColor: widget.palette.scaffoldColor(1.0),
      appBarBackgroundColor: widget.palette.scaffoldColor(1.0),
      annotationRegion: widget.palette.annotationRegionColor(1.0),
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: _buildDotsIndicators(),
      body: BorderlessWrapperWidget(
        top: true,
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Constants.verticalPadding,
              ),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.42,
                width: MediaQuery.of(context).size.width * 0.42,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      _introAssets()[currentIndexScreen],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowGlow();
                  return true;
                },
                child: CarouselSlider(
                  carouselController: _buttonCarouselController,
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0,
                    onPageChanged: _onPageChanged,
                    enlargeCenterPage: true,
                    disableCenter: false,
                    scrollPhysics: const ClampingScrollPhysics(),
                  ),
                  items: _introMessages().map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.bottomCenter,
                          child: IntroItemWidget(
                            title: item['title'],
                            subTitle: item['subTitle'],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding,
                  vertical: Constants.verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.caption!.merge(
                          const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: AppLocalizations.of(context)!.clickToAccept,
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.termAndCondition,
                            style: TextStyle(
                              color: widget.palette.linkColor(1.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 34.0,
                    child: ButtonWidget(
                      onPressed: () {
                        Navigator.pushNamed(
                            context,
                            AuthScreen.routeName,
                        );
                      },
                      enabled: true,
                      child: ButtonWidget.buttonTextChild(
                        context: context,
                        enabled: true,
                        text: AppLocalizations.of(context)!.beginAndAccept.toUpperCase(),
                        textStyle: TextStyle(
                          color: widget.palette.secondaryBrandColor(1),
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ButtonStyleWrapper(
                        palette: widget.palette,
                        enabled: true,
                      ).build(context).copyWith(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) {
                            return widget.palette.secondaryBrandColor(0.1);
                          },
                        ),
                        overlayColor: MaterialStateColor.resolveWith((states) {
                          return widget.palette.secondaryBrandColor(0.2);
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Render

  Widget _buildDotsIndicators() {
    return DotsIndicator(
      dotsCount: screenLength,
      position: currentIndexScreen.toDouble(),
      decorator: DotsDecorator(
        color: widget.palette.captionColor(0.3),
        activeColor: widget.palette.secondaryBrandColor(1.0),
        size: const Size.square(8.0),
        activeSize: const Size(16.0, 8.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  // Callback

  void _onPageChanged(int index, _) {
    setState(() {
      currentIndexScreen = index;
    });
  }

  List<Map<String, dynamic>> _introMessages() {
    return [
      {
        "title": AppLocalizations.of(context)!.enjoySeriesMovies,
        "subTitle": "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from.",
      },
      {
        "title": AppLocalizations.of(context)!.subscription,
        "subTitle": "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from.",
      },
      {
        "title": AppLocalizations.of(context)!.download,
        "subTitle": "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from.",
      },
    ];
  }

  List<String> _introAssets() {
    return [
      'assets/images/enjoy_movies.png',
      'assets/images/suscription_payment.png',
      'assets/images/download_illustration.png',
    ];
  }
}
