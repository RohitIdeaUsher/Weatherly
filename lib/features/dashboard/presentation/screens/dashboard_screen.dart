import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';
import 'package:weatherly/components/saved_button.dart';
import 'package:weatherly/components/theme_toggle.dart';
import 'package:weatherly/features/dashboard/presentation/widgets/weekly_forecast_tile.dart';
import 'package:weatherly/features/dashboard/domain/weather_model.dart';
import 'package:weatherly/features/dashboard/presentation/screens/custom_search.dart';
import 'package:weatherly/features/dashboard/presentation/provider/dashboard_controller.dart';
import 'package:weatherly/features/saved_city/presentation/screen/saved_city.dart';
import 'package:weatherly/main.dart';
import 'package:weatherly/core/location_service.dart';
import 'package:weatherly/core/sized_box_extension.dart';
import 'package:weatherly/core/theme_notifier.dart';

class DashBoardScreen extends ConsumerWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internetStatus = ref.watch(internetConnectionProvider);
    final dashboradController = ref.watch(dashboardControllerProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    return Scaffold(
      appBar: _appBar(ref, context, themeNotifier),
      backgroundColor: Theme.of(context).canvasColor,
      body: internetStatus.when(
        data: (status) {
          switch (status) {
            case InternetStatus.connected:
              return dashboradController.when(
                data: (data) {
                  return body(context, data);
                },
                error: (e, st) => Center(child: Text(e.toString())),
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            case InternetStatus.disconnected:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.network_check, size: 150.h, color: Colors.amber),
                    Text(
                      'No internet connection.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              );
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.amber),
                Text(
                  'No details found.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ],
            ),
      ),
    );
  }

  AppBar _appBar(
    WidgetRef ref,
    BuildContext context,
    ThemeNotifier themeNotifier,
  ) {
    return AppBar(
      backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/icons/app_icon.png", height: 40.h),
          Text(
            'Weatherly',
            style: TextStyle(color: Colors.white, fontSize: 22.sp),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SavedCity()),
            );
            if (result != null) {
              await LocationService.getCoordinatesFromAddress(
                result,
                onSuccess: (lat, long) async {
                  await ref
                      .read(dashboardControllerProvider.notifier)
                      .getLocationWiseWeather(lat: lat, long: long);
                },
              );
            }
          },
          icon: Icon(Icons.bookmark_rounded, color: Colors.white, size: 30.h),
        ),
        IconButton(
          onPressed: () async {
            await ref
                .read(dashboardControllerProvider.notifier)
                .getLocationWiseWeather();
          },
          icon: Icon(Icons.gps_fixed_rounded, color: Colors.white, size: 30.h),
        ),
        IconButton(
          onPressed: () async {
            final result = await showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
            if (result != null) {
              await LocationService.getCoordinatesFromAddress(
                result,
                onSuccess: (lat, long) async {
                  await ref
                      .read(dashboardControllerProvider.notifier)
                      .getLocationWiseWeather(lat: lat, long: long);
                },
              );
            }
          },
          icon: Icon(Icons.search, color: Colors.white, size: 30.h),
        ),

        ThemeToggleButton(),
        16.sbW,
      ],
    );
  }

  ListView body(
    BuildContext context,
    DasboardScreenState? dashboardScreenState,
  ) {
    final model = dashboardScreenState?.weatherData;
    final forecast = dashboardScreenState?.forecastData ?? [];
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      children: [
        SavedButton(city: model!),

        Center(
          child: Text(
            model.name ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),

        10.sbH,
        Center(
          child: Text(
            _convertToLocalTime(model.dt ?? 0),

            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        40.sbH,
        UnconstrainedBox(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Center(
                    child: Text(
                      model.weather?.firstOrNull?.main ?? '',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Center(
                    child: Text(
                      '${model.main?.temp?.toString() ?? 0.0}°C',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        40.sbH,

        SvgPicture.asset(
          WeatherModel.getWeatherIconSvg(
            model.weather?.firstOrNull?.icon ?? '0',
          ),
          height: 200.h,
          width: 200.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 4.w),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonDataColumn(
                    icon: Icons.wind_power_rounded,
                    title: 'Wind',
                    value: '${model.wind?.speed ?? 0}m/s',
                  ),
                  commonDataColumn(
                    icon: Icons.sunny,
                    title: 'Max',
                    value: '${model.main?.tempMax ?? 0}°C',
                  ),
                  commonDataColumn(
                    icon: Icons.wb_sunny_outlined,
                    title: 'Min',
                    value: '${model.main?.tempMin ?? 0}°C',
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Divider(color: Theme.of(context).cardColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonDataColumn(
                    icon: Icons.water_drop,
                    iconColor: Colors.amber,
                    title: 'Humidity',
                    value: '${model.main?.humidity ?? 0}%',
                  ),
                  commonDataColumn(
                    icon: Icons.air,
                    iconColor: Colors.amber,
                    title: 'Pressure',
                    value: '${model.main?.pressure ?? 0}hPa',
                  ),
                  commonDataColumn(
                    icon: Icons.leaderboard,
                    iconColor: Colors.amber,
                    title: 'Sea-Level',
                    value: '${model.main?.seaLevel ?? 0}km',
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          'Forecast for next 7 days',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ...List.generate(
          forecast.length,
          (index) => WeeklyForecastTile(model: forecast[index]),
        ),
      ],
    );
  }

  Column commonDataColumn({
    required IconData icon,
    Color? iconColor,
    String title = '',
    String value = '',
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor ?? Colors.white),
        5.sbH,
        weatherInfoCard(title: title, value: value),
      ],
    );
  }

  Column weatherInfoCard({required String title, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  String _convertToLocalTime(int dt) {
    final date = DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true);
    return DateFormat('dd MMMM yyyy').format(date);
  }
}
