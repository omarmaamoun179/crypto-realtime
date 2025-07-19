import 'package:crypto_realtime/core/bloc/cubit/theme_cubit.dart';
import 'package:crypto_realtime/core/bloc/cubit/theme_state.dart';
import 'package:crypto_realtime/core/themes/theme.dart';
import 'package:crypto_realtime/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'core/utils/connection_checker.dart';
import 'features/home_crypto/presentation/pages/home_page.dart';

const inspectorEnabled = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConnectionChecker().initialize();
  runApp(const RequestsInspector(enabled: inspectorEnabled, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Injector().themeCubit,
        ),
        BlocProvider(
          create: (context) => Injector().homeCryptoCubit..fetchAllCryptoData(),
        ),
      ],
      child: Builder(builder: (context) {
        var themeCubit = context.watch<ThemeCubit>();
        return MaterialApp(
          title: 'Crypto Realtime',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeCubit.state.status == ThemeStatus.light
              ? ThemeMode.light
              : ThemeMode.dark,
          home: const HomePage(),
        );
      }),
    );
  }
}
