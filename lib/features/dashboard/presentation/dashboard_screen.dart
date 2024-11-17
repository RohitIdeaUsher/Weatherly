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

class DashBoardScreen extends ConsumerWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboradController = ref.watch(dashboardControllerProvider);

    // final forecastListing = ref.watch(getFiveDaysWeatherForecastProvider);

    return Scaffold(
      appBar: _appBar(ref, context),
      backgroundColor: const Color(0xff060720),
      body: dashboradController.when(
        data: body,
        error: (e, st) => Center(child: Text(e.toString())),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  AppBar _appBar(WidgetRef ref, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text(
        'Weatherly',
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              // await ref
              //     .read(dashboardControllerProvider.notifier)
              //     .getLocationWiseWeather();
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

  ListView body(DasboardScreenState? dashboardScreenState) {
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
            style: const TextStyle(fontSize: 40, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Center(
          child: Text(
            _convertToLocalTime(model?.dt ?? 0),
            // DateFormat('dd MMMM yyyy').format(DateTime.now()),
            style:
                TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.5)),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        UnconstrainedBox(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
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
                      gradient: const LinearGradient(colors: [
                        // Color.fromARGB(255, 21, 85, 169),
                        // Color.fromARGB(255, 44, 162, 246),
                        Colors.lightBlueAccent,
                        Colors.lightBlue
                      ])),
                  child: Center(
                    child: Text(
                      model?.weather?.firstOrNull?.main ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Center(
                    child: Text(
                      '${model?.main?.temp?.toString() ?? 0.0}°C',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5), fontSize: 18),
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
            color: Colors.blue.shade200,
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
                child: const Divider(
                  color: Colors.white,
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
        const Text('Forecast for next 5 days',
            style: TextStyle(color: Colors.white, fontSize: 20)),
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
