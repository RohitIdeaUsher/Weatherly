import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weatherly/components/weekly_forecast_tile.dart';
import 'package:weatherly/features/dashboard/domain/weather_model.dart';
import 'package:weatherly/features/dashboard/presentation/custom_search.dart';
import 'package:weatherly/features/dashboard/presentation/dashboard_controller.dart';
import 'package:weatherly/util/location_service.dart';
import 'package:weatherly/util/theme_notifier.dart';

class DashBoardScreen extends ConsumerWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboradController = ref.watch(dashboardControllerProvider);

    // final forecastListing = ref.watch(getFiveDaysWeatherForecastProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    return Scaffold(
      appBar: _appBar(ref, context, themeNotifier),
      backgroundColor: Theme.of(context).canvasColor,
      body: dashboradController.when(
        data: (data) {
          return body(context, data);
        },
        error: (e, st) => Center(child: Text(e.toString())),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  AppBar _appBar(
      WidgetRef ref, BuildContext context, ThemeNotifier themeNotifier) {
    return AppBar(
      backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text(
        'Weatherly',
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              themeNotifier.toggleTheme();
            },
            icon: Icon(Icons.brightness_4_outlined,
                color: Colors.white, size: 30.h)),
        SizedBox(
          width: 20.h,
        ),
        IconButton(
            onPressed: () async {
              await ref
                  .read(dashboardControllerProvider.notifier)
                  .getLocationWiseWeather();
            },
            icon:
                Icon(Icons.gps_fixed_rounded, color: Colors.white, size: 30.h)),
        SizedBox(
          width: 20.h,
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
              // log(result ?? 'No data');
            },
            icon: Icon(Icons.search, color: Colors.white, size: 30.h)),
      ],
    );
  }

  ListView body(
      BuildContext context, DasboardScreenState? dashboardScreenState) {
    final model = dashboardScreenState?.weatherData;
    final forecast = dashboardScreenState?.forecastData ?? [];
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      children: [
        SizedBox(
          height: 20.h,
        ),
        Center(
          child: Text(
            model?.name ?? '',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Center(
          child: Text(_convertToLocalTime(model?.dt ?? 0),
              // DateFormat('dd MMMM yyyy').format(DateTime.now()),
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
        ),
        SizedBox(
          height: 40.h,
        ),
        UnconstrainedBox(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor
                      // gradient: const LinearGradient(colors: [
                      //   Colors.lightBlueAccent,
                      //   Colors.lightBlue
                      // ])
                      ),
                  child: Center(
                    child: Text(
                      model?.weather?.firstOrNull?.main ?? '',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Center(
                    child: Text(
                      '${model?.main?.temp?.toString() ?? 0.0}°C',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        // Image.asset(
        SvgPicture.asset(
          WeatherModel.getWeatherIconSvg(
              model?.weather?.firstOrNull?.icon ?? '0'),
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
                      value: '${model?.wind?.speed ?? 0}m/s'),
                  commonDataColumn(
                      icon: Icons.sunny,
                      title: 'Max',
                      value: '${model?.main?.tempMax ?? 0}°C'),
                  commonDataColumn(
                      icon: Icons.wb_sunny_outlined,
                      title: 'Min',
                      value: '${model?.main?.tempMin ?? 0}°C'),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Divider(
                  color: Theme.of(context).cardColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonDataColumn(
                      icon: Icons.water_drop,
                      iconColor: Colors.amber,
                      title: 'Humidity',
                      value: '${model?.main?.humidity ?? 0}%'),
                  commonDataColumn(
                      icon: Icons.air,
                      iconColor: Colors.amber,
                      title: 'Pressure',
                      value: '${model?.main?.pressure ?? 0}hPa'),
                  commonDataColumn(
                      icon: Icons.leaderboard,
                      iconColor: Colors.amber,
                      title: 'Sea-Level',
                      value: '${model?.main?.seaLevel ?? 0}km'),
                ],
              ),
            ],
          ),
        ),
        const Text('Forecast for next 5 days', style: TextStyle(fontSize: 20)),
        ...List.generate(
            forecast.length,
            (index) => WeeklyForecastTile(
                  model: forecast[index],
                )),
      ],
    );
  }

  Column commonDataColumn(
      {required IconData icon,
      Color? iconColor,
      String title = '',
      String value = ''}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          // Icons.straight_rounded
          icon,
          color: iconColor ?? Colors.white,
        ),
        SizedBox(height: 5.h),
        weatherInfoCard(
          title: title,
          value: value,
        ),
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
        )
      ],
    );
  }

  String _convertToLocalTime(int dt) {
    final date = DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true);
    return DateFormat('dd MMMM yyyy').format(date);
  }
}
