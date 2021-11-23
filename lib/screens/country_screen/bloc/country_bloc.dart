import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:stream/models/remote/country.dart';
import 'package:stream/repository/country_repository.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc({
    required this.repository,
  })  : super(Initial());

  final CountryRepository repository;

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    if (event is LoadCountries) {
      yield* _mapLoadToState(event);
    }

    if (event is SearchCountry) {
      yield* _mapSearchToState(event);
    }
  }

  Stream<CountryState> _mapLoadToState(LoadCountries event) async* {
    yield LoadingCountries();

    try {
      final apiResponse = await repository.supportedCountries();

      if(apiResponse != null){
        if(apiResponse.code == 100){
          var countries = apiResponse.deserializeCountries();

          yield LoadSuccess(
              filteredCountries: countries,
              countries: countries,
          );
        }else{
          yield const LoadSuccess(
              countries: [],
              filteredCountries: [],
          );
        }

        return;
      }

      yield const LoadFailed();
    } catch (error) {
      yield const LoadFailed();
    }
  }

  Stream<CountryState> _mapSearchToState(SearchCountry event) async* {
    if(state is LoadSuccess) {
      final currentState = state as LoadSuccess;

      if(event.query.isNotEmpty) {
        var countries = currentState.countries.where((item) {
          return item.designation.toLowerCase().contains(event.query.toString().toLowerCase());
        }).toList();

        yield LoadSuccess(
          status: currentState.status == CountryStatus.initial ? CountryStatus.intermediate : CountryStatus.initial,
          countries: currentState.countries,
          filteredCountries: countries,
        );
      } else {
        yield LoadSuccess(
          status: currentState.status == CountryStatus.initial ? CountryStatus.intermediate : CountryStatus.initial,
          countries: currentState.countries,
          filteredCountries: currentState.countries,
        );
      }
    }
  }
}
