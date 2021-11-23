import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import 'package:stream/config/config.dart';
import 'package:stream/config/hooks.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_bar_action/app_bar_action.dart';
import 'package:stream/widgets/button/button.dart';
import 'package:stream/widgets/divider/divider.dart';
import 'package:stream/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class DateInputWidget extends StatefulWidget {
  DateInputWidget({
    Key? key,
    this.onChanged,
    this.hintText,
    this.value,
    this.minYear,
    this.maxYear,
    this.format = Constants.datePickersFormat,
  }) : super(key: key);

  late Palette palette;

  final DateTime? value;
  final int? minYear;
  final int? maxYear;
  final String? hintText;
  final String? format;
  final Function(String)? onChanged;

  @override
  State<StatefulWidget> createState() => _DateInputWidgetState();
}

class _DateInputWidgetState extends State<DateInputWidget> {
  late DateTime? value;
  late DateTime? tempValue;
  late DatePickerController controller;

  @override
  void initState() {
    super.initState();

    tempValue = _initialValue();
    value = widget.value;
    controller = DatePickerController(
      initialDateTime: _initialValue(),
      minYear: widget.minYear ?? 2011,
      maxYear: widget.maxYear ?? 2050,
    );
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

    var style = Theme.of(context).textTheme.subtitle1!.merge(
      const TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w500,
      ),
    );

    var hintStyle = Theme.of(context).textTheme.subtitle1!.merge(
      TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w500,
        color: widget.palette.captionColor(0.8),
      ),
    );

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              _showPicker();
            },
            child: Container(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 18.0,
                bottom: 18.0,
              ),
              child: Text(
                value == null ? (widget.hintText ?? AppLocalizations.of(context)!.selectDate) : Hooks.formatDate(value!, Constants.datePickersFormat,),
                style:  value == null ? hintStyle : style,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 4.0,
          ),
          child: Row(
            children: [
              _buildSuffix(),
              const SizedBox(width: 10.0),
              AppBarActionWidget(
                onPressed: () {
                  _showPicker();
                },
                splashColor: widget.palette.splashLightColor(1.0),
                highLightColor: widget.palette.highLightLightColor(1.0),
                icon: Icon(
                  Icons.today_outlined,
                  size: 20.0,
                  color: widget.palette.captionColor(1.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Render

   Widget _buildSuffix() {
    return Icon(
      Icons.check_circle,
      size: 15.0,
      color: widget.palette.secondaryBrandColor(1.0),
    );

    return SizedBox(
        height: 15.0,
        width: 15.0,
        child: SpinnerWidget(
          colors: AlwaysStoppedAnimation<Color>(widget.palette.secondaryBrandColor(1.0),),
          strokeWidth: 1.6,
        )
    );
   }

   // Bottom sheet

  void _showPicker() {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            color: widget.palette.scaffoldColor(1.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding,
                  vertical: 14.0,
                ),
                child: Text(
                  AppLocalizations.of(context)!.selectDate,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1!.merge(
                    const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6.0),
              ScrollDatePicker(
                controller: controller,
                height: 200.0,
                locale: DatePickerLocale.en_us,
                pickerDecoration: BoxDecoration(
                  color: widget.palette.secondaryBrandColor(0.1),
                  border: Border.all(
                    color: widget.palette.secondaryBrandColor(0.2),
                    width: 0.4,
                  ),
                ),
                config: DatePickerConfig(
                  isLoop: false,
                  itemExtent: 38.0,
                  diameterRatio: 7.0,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: widget.palette.captionColor(1.0),
                    fontSize: 14.0,
                  ),
                  selectedTextStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: widget.palette.secondaryBrandColor(1.0),
                    fontSize: 16.0,
                  ),
                ),
                onChanged: (value) {
                  tempValue = value;
                },
              ),
              const SizedBox(height: 6.0),
              DividerWidget(),
              SizedBox(
                height: 44.0,
                width: MediaQuery.of(context).size.width,
                child: ButtonWidget(
                  onPressed: () {
                    Navigator.pop(context);
                    _selectDate();
                  },
                  enabled: true,
                  child: ButtonWidget.buttonTextChild(
                    context: context,
                    enabled: true,
                    text: "OK",
                    textStyle: TextStyle(
                      color: widget.palette.secondaryBrandColor(1),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ButtonStyleWrapper(
                    palette: widget.palette,
                    enabled: true,
                  ).build(context).copyWith(
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      return Colors.transparent;
                    },
                    ),
                    overlayColor: MaterialStateColor.resolveWith((states) {
                      return widget.palette.secondaryBrandColor(0.1);
                    }),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Callback

  DateTime _initialValue() {
    return widget.value ?? DateTime.now();
  }

  void _selectDate() {
    setState(() {
      value = tempValue;
      controller = DatePickerController(
        initialDateTime: tempValue!,
        minYear: widget.minYear ?? 2011,
        maxYear: widget.maxYear ?? 2050,
      );
    });
  }
}