import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

import 'package:stream/app/app.dart';
import 'package:stream/blocs/auth/auth_bloc.dart';
import 'package:stream/blocs/localization/localization_cubit.dart';
import 'package:stream/blocs/theme/theme_cubit.dart';
import 'package:stream/config/hooks.dart';
import 'package:stream/config/simple_bloc_observer.dart';
import 'package:stream/repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hooks.initServices();
  Bloc.observer = SimpleBlocObserver();
  // await StorageRepository.clearAll();

  // Workmanager().initialize(
  //   taskCallbackDispatcher, // The top level function, aka callbackDispatcher
  //   isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  // );

  runApp(const OStreamApp());
}

class OStreamApp extends StatelessWidget {
  const OStreamApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Hooks.setOrientation([DeviceOrientation.portraitUp]);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LocalizationCubit>(
            create: (BuildContext context) {
              return LocalizationCubit();
            },
          ),
          BlocProvider<ThemeCubit>(
            create: (BuildContext context) {
              return ThemeCubit();
            },
          ),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) {
              return AuthBloc(
                userRepository: RepositoryProvider.of<UserRepository>(
                  context,
                ),
              )..add(
                  const AuthStatusChanged(
                    status: AuthStatus.unknown,
                  ),
                );
            },
          ),
        ],
        child: const App(),
      ),
    );
  }
}

// Executive tasks

void taskCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    var taskResult = true;
    debugPrint("Native called background task started: $task");

    switch (task) {
      case Workmanager.iOSBackgroundTask:
        debugPrint("iOS background fetch delegate ran");
        break;
    }

    debugPrint("Native called background task ended: $task");
    return Future.value(taskResult);
  });
}
