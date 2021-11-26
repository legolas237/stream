import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:stream/config/config.dart';
import 'package:stream/models/remote/country.dart';
import 'package:stream/screens/country_screen/bloc/country_bloc.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_bar_action/app_bar_action.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';
import 'package:stream/widgets/border_wrapper/border_wrapper.dart';
import 'package:stream/widgets/error_wrapper/error_wrapper.dart';
import 'package:stream/widgets/list_tile/list_tile.dart';
import 'package:stream/widgets/list_tile_title/list_tile_title.dart';
import 'package:stream/widgets/spinner/spinner.dart';
import 'package:substring_highlight/substring_highlight.dart';

// ignore: must_be_immutable
class CountryScreen extends StatefulWidget {
  CountryScreen({
    Key? key,
    this.country = Constants.defaultCountry,
  }) : super(key: key);

  late Palette palette;

  final Country? country;

  @override
  State<StatefulWidget> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  late Country country;
  late bool searching;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
    searching = false;
    country = widget.country!;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    var countryBloc = BlocProvider.of<CountryBloc>(context);
    if(BlocProvider.of<CountryBloc>(context).state is Initial) {
      countryBloc.add(LoadCountries());
    }

    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        return ScaffoldWidget(
          appBarBackgroundColor: !searching ? widget.palette.secondarySplashColor(1.0) : widget.palette.whiteColor(1.0),
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: _buildAppTitle(),
          leading: AppBarActionWidget(
            icon: AppBarActionWidget.buildIcon(
              icon: Icons.arrow_back_outlined,
              color: searching ? widget.palette.captionColor(1.0) : widget.palette.whiteColor(1.0),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: _buildAppActions(state),
          body: BorderlessWrapperWidget(
            top: searching,
            bottom: false,
            child: _buildWidgetTree(state),
          ),
        );
      },
    );
  }

  // Render

  Widget _buildWidgetTree(CountryState state) {
    if(state is LoadFailed) {
      return _buildErrorWrapper();
    }

    if(state is LoadSuccess) {
      return GroupedListView(
        stickyHeaderBackgroundColor: widget.palette.whiteColor(1.0),
        elements: state.filteredCountries,
        groupBy: (currentCountry) => (currentCountry as Country).designation[0],
        groupHeaderBuilder: (Country value) {
          return Container(
            color: widget.palette.whiteColor(1.0),
            child: ListTileTitleWidget(
              leading: const SizedBox(),
              title: value.designation[0].toUpperCase(),
              style: Theme.of(context).textTheme.subtitle2!.merge(
                TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: widget.palette.secondaryBrandColor(1.0),
                ),
              ),
            ),
          );
        },
        groupSeparatorBuilder: (String value) {
          return ListTileTitleWidget(
            leading: const SizedBox(),
            title: value.toUpperCase(),
            style: Theme.of(context).textTheme.subtitle2!.merge(
              TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: widget.palette.secondaryBrandColor(1.0),
              ),
            ),
          );
        },
        itemBuilder: (context, dynamic currentCountry) {
          return ListTileWidget(
            onTap: () {
              setState(() {
                country = currentCountry;
              });
            },
            leading: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: Image.asset(
                  'icons/flags/png/${currentCountry.alphaCode.toLowerCase()}.png',
                  package: "country_icons",
                  fit: BoxFit.cover,
                  height: 16.0,
                  width: 16.0,
                ),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SubstringHighlight(
                    text: currentCountry.designation,
                    term: controller.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    caseSensitive: true,
                    textStyle: Theme.of(context).textTheme.subtitle2!.merge(
                      const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    textStyleHighlight: Theme.of(context).textTheme.subtitle2!.merge(
                      TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: widget.palette.accentBrandColor(1.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                SubstringHighlight(
                  text: currentCountry.dialCode,
                  term: controller.text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  caseSensitive: true,
                  textStyle: Theme.of(context).textTheme.caption!.merge(
                    const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  textStyleHighlight: Theme.of(context).textTheme.subtitle2!.merge(
                    TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: widget.palette.accentBrandColor(1.0),
                    ),
                  ),
                ),
                const SizedBox(width: 14.0),
                Icon(
                  Icons.radio_button_checked_outlined,
                  size: 14.0,
                  color: currentCountry.alphaCode == country.alphaCode ? widget.palette.secondaryBrandColor(0.8) : widget.palette.captionColor(0.4),
                ),
              ],
            ),
            subtitle: currentCountry.nativeName != currentCountry.designation ? SubstringHighlight(
              text: currentCountry.nativeName,
              term: controller.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              caseSensitive: true,
              textStyle: Theme.of(context).textTheme.caption!.merge(
                const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              textStyleHighlight: Theme.of(context).textTheme.caption!.merge(
                TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: widget.palette.accentBrandColor(1.0),
                ),
              ),
            ) : null,
          );
        },
        // itemComparator: (item1, item2) => (item1 as Country).designation[0] != (item2 as Country).designation[0] ? 1 : 0,
        useStickyGroupSeparators: true,
        floatingHeader: false,
        order: GroupedListOrder.ASC,
      );
    }

    return const SizedBox();
  }

  List<Widget> _buildAppActions(CountryState state) {
    if(state is LoadFailed) {
      return const [];
    }

    if(state is LoadingCountries) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 14.0,
              width: 14.0,
              child: SpinnerWidget(
                strokeWidth: 1.8,
                colors: AlwaysStoppedAnimation<Color>(
                  widget.palette.whiteColor(1.0),
                ),
              ),
            ),
            const SizedBox(width: 14.0),
          ],
        )
      ];
    }

    if(searching) {
      return [
        Row(
          children: [
            AppBarActionWidget(
              splashColor: widget.palette.splashLightColor(1.0),
              highLightColor: widget.palette.highLightLightColor(1.0),
              icon: AppBarActionWidget.buildIcon(
                icon: Icons.close_outlined,
                color: widget.palette.captionColor(1.0),
              ),
              onPressed: () {
                setState(() {
                  controller.clear();
                  searching = false;
                });
                BlocProvider.of<CountryBloc>(context).add(const SearchCountry(query: '',),);
              },
            ),
            AppBarActionWidget(
              splashColor: widget.palette.splashLightColor(1.0),
              highLightColor: widget.palette.highLightLightColor(1.0),
              icon: AppBarActionWidget.buildIcon(
                icon: Icons.check_outlined,
                color: !searching ? widget.palette.whiteColor(1.0) : widget.palette.captionColor(1.0),
              ),
              onPressed: () {
                Navigator.pop<Country>(context, country);
              },
            ),
          ],
        )
      ];
    }

    return [
      Row(
        children: [
          AppBarActionWidget(
            icon: AppBarActionWidget.buildIcon(
              icon: Icons.search_outlined,
              color: widget.palette.whiteColor(1.0),
            ),
            onPressed: () {
              setState(() {
                searching = true;
              });
            },
          ),
          AppBarActionWidget(
            icon: AppBarActionWidget.buildIcon(
              icon: Icons.check_outlined,
              color: widget.palette.whiteColor(1.0),
            ),
            onPressed: () {
              Navigator.pop<Country>(context, country);
            },
          ),
        ],
      )
    ];
  }

  Widget _buildAppTitle() {
    if(searching) {
      return TextField(
        autofocus: false,
        controller: controller,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.transparent,
          hintText: AppLocalizations.of(context)!.typeToSearch,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 4.0,
            vertical: 14.0,
          ),
          hintStyle: Theme.of(context).textTheme.caption!.merge(
            const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        style: Theme.of(context).textTheme.subtitle2!.merge(
          const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        onChanged: (query) {
          BlocProvider.of<CountryBloc>(context).add(SearchCountry(query: query,),);
        },
      );
    }

    return ScaffoldWidget.buildTitle(
      context,
      widget.palette,
      AppLocalizations.of(context)!.selectCountry,
      widget.palette.whiteColor(1.0),
    );
   }

  Widget _buildErrorWrapper() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.16,
          ),
          child: ErrorWrapperWidget(
            assetImage: widget.palette.assetsIllustration()['error'],
            title: AppLocalizations.of(context)!.oopsError,
            subTitle: AppLocalizations.of(context)!.unableToLoadCountries,
            callback: () {
              BlocProvider.of<CountryBloc>(context).add(LoadCountries());
            },
          ),
        ),
      ],
    );
  }
}