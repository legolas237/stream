part of 'country_bloc.dart';

@immutable
abstract class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object> get props => [];
}

class LoadCountries extends CountryEvent {
  @override
  String toString() => 'LoadCountries';
}

class SearchCountry extends CountryEvent {
  const SearchCountry({required this.query});

  final String query;

  @override
  String toString() => 'SearchCountry';
}
