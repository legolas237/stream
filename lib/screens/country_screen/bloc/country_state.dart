part of 'country_bloc.dart';

enum CountryStatus {
  intermediate,
  initial,
}

@immutable
abstract class CountryState extends Equatable{
  const CountryState();

  @override
  List<Object?> get props => [];
}

class Initial extends CountryState {
  @override
  String toString() => 'CountryInitial';
}

class LoadingCountries extends CountryState {
  @override
  String toString() => 'LoadingCountries';
}

class LoadSuccess extends CountryState {
  const LoadSuccess({
    required this.countries,
    required this.filteredCountries,
    this.status = CountryStatus.initial,
  });

  final List <Country> countries;
  final List <Country> filteredCountries;
  final CountryStatus status;

  @override
  String toString() => 'LoadSuccess';

  @override
  List<Object?> get props => [countries, status, filteredCountries];
}

class LoadFailed extends CountryState {
  const LoadFailed([this.error]);

  final String? error;

  @override
  List<Object?> get props => [error];

  @override
  String toString() => 'LoadFailed';
}
