import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream/config/config.dart';
import 'package:stream/models/remote/country.dart';
import 'package:stream/repository/country_repository.dart';
import 'package:stream/screens/country_screen/bloc/country_bloc.dart';
import 'package:stream/screens/country_screen/country_screen.dart';

class CountryScreenBlocProvider extends StatelessWidget {
  const CountryScreenBlocProvider({
    Key? key,
    this.country = Constants.defaultCountry,
  }) : super(key: key);

  final Country? country;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountryBloc(
        repository: CountryRepository(),
      ),
      child: CountryScreen(country: country),
    );
  }
}
