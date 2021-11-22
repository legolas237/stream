import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/config/config.dart';
import 'package:stream/models/remote/country.dart';
import 'package:stream/screens/auth_screen/widgets/auth_input.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/spinner/spinner.dart';

class PhoneNumber {
  PhoneNumber({
    required this.phoneNumber,
    required this.isValid,
    this.country,
  });

  String phoneNumber;
  Country? country;
  bool isValid;
}

// ignore: must_be_immutable
class TelephoneInputWidget extends StatefulWidget {
  TelephoneInputWidget({
    Key? key,
    this.onChanged,
    this.controller,
    required this.country,
  }) : super(key: key);

  late Palette palette;

  final TextEditingController? controller;
  final Country country;
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

    country = widget.country;
    controller = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    // Values
    phoneNumber = PhoneNumber(phoneNumber: "", isValid: false);

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
                    keyboardType: TextInputType.number,
                    hintText: AppLocalizations.of(context)!.phoneNumber,
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                      const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    inputFormatters: [],
                    contentPadding: const EdgeInsets.only(
                      left: 20.0,
                      top: 18.0,
                      bottom: 18.0,
                    ),
                    onChanged: (value) {
                      // parsePhoneNumber();
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
      child: Row(
        children: [
          Image.asset(
            'icons/flags/png/${country.isoCode.toLowerCase()}.png',
            package: "country_icons",
            width: 22.0,
            height: 22.0,
          ),
          const SizedBox(width: 4.0),
          Text(
            country.dialCode,
            style: Theme.of(context).textTheme.subtitle1!.merge(
              const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

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

   // Callback

  // void parsePhoneNumber() async {
  //   phoneNumber.country = country;
  //
  //   try {
  //     final Map<String, dynamic> parsedPhoneNumber = await FlutterLibphonenumber().parse(
  //       '${country.dialCode} ${controller.text}',
  //       region: country.isoCode.toUpperCase(),
  //     );
  //
  //     phoneNumber.phoneNumber = parsedPhoneNumber['e164'];
  //     phoneNumber.isValid = true;
  //   } catch (error) {
  //     print(error);
  //     phoneNumber.phoneNumber = "";
  //     phoneNumber.isValid = false;
  //   }
  //
  //   if(widget.onChanged != null) widget.onChanged!(phoneNumber);
  // }
}