import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:stream/models/util/config.dart';
import 'package:stream/repository/storage_repository.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit()
      : super(
          LocalizationState(
            language: StorageRepository.getLanguage(),
          ),
        );

  Future<void> languageHasChanged(String language) async {
    var oldConfig = StorageRepository.getConfig();
    late Config newConfig;

    if (oldConfig != null) {
      newConfig = oldConfig.copyWith(
        language: language.toLowerCase(),
      );
    } else {
      newConfig = Config(
        language: language.toLowerCase(),
      );
    }

    await StorageRepository.setConfig(newConfig);
    emit(state.change(
      language: language,
    ));
  }
}
