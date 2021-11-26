import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import 'package:stream/config/config.dart';
import 'package:stream/models/remote/country.dart';
import 'package:stream/widgets/auth_input/auth_input.dart';
import 'package:stream/screens/country_screen/country_screen_bloc_provider.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

class PhoneNumber {
  PhoneNumber({
    required this.phoneNumber,
    required this.nationalNumber,
    required this.isValid,
    this.country = Constants.defaultCountry,
  });

  String phoneNumber;
  String nationalNumber;
  Country? country;
  bool isValid;
}

// ignore: must_be_immutable
class TelephoneInputWidget extends StatefulWidget {
  TelephoneInputWidget({
    Key? key,
    this.onChanged,
    this.controller,
    this.phoneNumber,
    this.allowValidation = false,
    this.readOnly = false,
  }) : super(key: key);

  late Palette palette;

  final bool readOnly;
  final PhoneNumber? phoneNumber;
  final bool allowValidation;
  final TextEditingController? controller;
  final ValueChanged<PhoneNumber>? onChanged;

  @override
  State<StatefulWidget> createState() => _TelephoneInputWidgetState();
}

class _TelephoneInputWidgetState extends State<TelephoneInputWidget> {
  late Country country;
  late PhoneNumber phoneNumber;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    phoneNumber = widget.phoneNumber ?? PhoneNumber(phoneNumber: "", nationalNumber: "", isValid: false,);
    country = phoneNumber.country!;
    controller = widget.controller ?? TextEditingController(
        text: phoneNumber.nationalNumber,
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

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
              left: Constants.horizontalPadding,
            ),
            child: Row(
              children: [
                _buildPrefix(),
                Expanded(
                  child: AuthInputWidget(
                    controller: controller,
                    readOnly: widget.readOnly,
                    keyboardType: TextInputType.number,
                    hintText: AppLocalizations.of(context)!.phoneNumber,
                    inputFormatters: [
                      LibPhonenumberTextFormatter(
                        overrideSkipCountryCode: country.alphaCode.toUpperCase(),
                        phoneNumberType: PhoneNumberType.mobile,
                        phoneNumberFormat: PhoneNumberFormat.national,
                      ),
                    ],
                    contentPadding: const EdgeInsets.only(
                      left: 20.0,
                      top: 18.0,
                      bottom: 18.0,
                    ),
                    onChanged: (value) {
                      _parsePhoneNumber();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 20.0,
          ),
          child: _buildSuffix(),
        ),
      ],
    );
  }

  // Render

  Widget _buildPrefix() {
    return GestureDetector(
      onTap: () {
        if(! widget.readOnly) {
          _navigateToGetCountry();
        }
      },
      child: Row(
        children: [
          Image.asset(
            'icons/flags/png/${country.alphaCode.toLowerCase()}.png',
            package: "country_icons",
            width: 22.0,
            height: 22.0,
          ),
          const SizedBox(width: 4.0),
          Text(
            country.dialCode,
            style: Theme.of(context).textTheme.subtitle1!.merge(
              TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: widget.readOnly ? widget.palette.captionColor(0.8) : widget.palette.textColor(1.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuffix() {
    if(phoneNumber.isValid) {
      return Icon(
        Icons.check_circle,
        size: 15.0,
        color: widget.readOnly ? widget.palette.captionColor(0.8) : widget.palette.secondaryBrandColor(1.0),
      );
    }

    return Icon(
      Icons.check_circle,
      size: 15.0,
      color: widget.palette.captionColor(0.2),
    );
   }

   // Callback

  void _navigateToGetCountry() async {
    final Country? selectCountry = await Navigator.push<Country>(
        context,
        MaterialPageRoute(
            builder: (context) {
              return CountryScreenBlocProvider(country: country);
            },
        ),
    );

    if(selectCountry != null) {
      setState(() {
        country = selectCountry;
      });
    }
  }

  void _parsePhoneNumber() async {
    phoneNumber.country = country;

    try {
      final Map<String, dynamic> parsedPhoneNumber = await FlutterLibphonenumber().parse(
        '${country.dialCode} ${controller.text}',
        region: country.alphaCode.toUpperCase(),
      );

      if(widget.allowValidation) {
        setState(() {
          phoneNumber.phoneNumber = parsedPhoneNumber['e164'];
          phoneNumber.isValid = true;
          phoneNumber.nationalNumber = parsedPhoneNumber['national_number'];
        });
      } else{
        phoneNumber.phoneNumber = parsedPhoneNumber['e164'];
        phoneNumber.isValid = true;
        phoneNumber.nationalNumber = parsedPhoneNumber['national_number'];
      }
    } catch (error) {
      if(widget.allowValidation) {
        setState(() {
          phoneNumber.phoneNumber = "";
          phoneNumber.nationalNumber = "";
          phoneNumber.isValid = false;
        });
      } else{
        phoneNumber.phoneNumber = "";
        phoneNumber.nationalNumber = "";
        phoneNumber.isValid = false;
      }
    }

    if(widget.onChanged != null) widget.onChanged!(phoneNumber);
  }
}