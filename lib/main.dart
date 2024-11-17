import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherly/dependencies.dart';
import 'package:weatherly/features/splash/presentation/splash_screen.dart';
import 'package:weatherly/util/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dependencies().setUpDependencyInjection();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then(
    (value) => {runApp(const ProviderScope(child: Weatherly()))},
  );
}

class Weatherly extends ConsumerWidget {
  const Weatherly({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return ScreenUtilInit(
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weatherly',
            theme: theme,
            home: const SplashScreen(),
          );
        });
  }
}
