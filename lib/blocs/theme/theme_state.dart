part of 'theme_cubit.dart';

enum ThemeStatusEnum { light, dark, other }

extension ThemeStatusExtensionString on ThemeStatusEnum {
  String? get value {
    switch (this) {
      case ThemeStatusEnum.light:
        return 'LIGHT';
      case ThemeStatusEnum.dark:
        return 'DARK';
      case ThemeStatusEnum.other:
        return 'OTHER';
      default:
        return null;
    }
  }
}

/// {@template theme_state}
/// [ThemeState] Manage theme app state
///
/// {@endtemplate}
class ThemeState extends Equatable {
  const ThemeState({
    this.status = ThemeStatusEnum.light,
    this.refresh = false,
  });

  final ThemeStatusEnum status;
  final bool refresh;

  ThemeState change({
    required ThemeStatusEnum status,
    bool refresh = false,
  }) {
    return ThemeState(
      status: status,
      refresh: refresh,
    );
  }

  @override
  List<Object> get props => [status];
}
