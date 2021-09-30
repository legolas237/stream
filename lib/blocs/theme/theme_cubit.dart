import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  Future<void> themeChanged(ThemeStatusEnum status) async {
    emit(state.change(status: status));
  }

  Future<void> refreshing() async {
    emit(state.change(
      status: state.status,
      refresh: !state.refresh,
    ));
  }
}
