part of 'localization_cubit.dart';

class LocalizationState extends Equatable {
  const LocalizationState({
    required this.language ,
  });

  final String language;

  LocalizationState change({
    required String language,
  }) {
    return LocalizationState(
      language: language,
    );
  }

  @override
  List<Object?> get props => [language];
}
