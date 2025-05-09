import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weatherly/services/dependencies.dart';
import 'package:weatherly/features/saved_city/domain/saved_city_model.dart';
import 'package:weatherly/features/splash/presentation/splash_screen.dart';
import 'package:weatherly/core/theme_notifier.dart';

final internetConnectionProvider = StreamProvider<InternetStatus>((ref) {
  return InternetConnection().onStatusChange;
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SavedCityModelAdapter());
  await Dependencies().setUpDependencyInjection();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => {runApp(const ProviderScope(child: Weatherly()))});
}

class Weatherly extends ConsumerWidget {
  const Weatherly({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return ScreenUtilInit(
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weatherly',
          theme: theme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
