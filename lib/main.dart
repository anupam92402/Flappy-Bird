import 'package:device_preview/device_preview.dart';
import 'package:flappy_bird/blocs/game_cubit/game_cubit.dart';
import 'package:flappy_bird/service_locator.dart';
import 'package:flappy_bird/utils/audio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';

void main() async {
  await setupServiceLocator();
  runApp(
    DevicePreview(
      enabled: false,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(audioHelper: getIt.get<AudioHelper>()),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Chewy'),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: const HomePage(),
      ),
    );
  }
}
