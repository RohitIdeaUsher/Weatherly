import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherly/features/dashboard/domain/forecast_model.dart';
import 'package:weatherly/features/dashboard/domain/weather_model.dart';

class WeeklyForecastTile extends StatelessWidget {
  const WeeklyForecastTile({
    super.key,
    required this.model,
  });

  final ForecastModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue.shade200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('EEEE').format(DateTime.parse(model.date!)),
                // ?? 'Sunday',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 5),
              Text(
                DateFormat('dd MMMM yyyy').format(DateTime.parse(model.date!)),
                style: const TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_downward_rounded,
                    color: Colors.green,
                    size: 18,
                  ),
                  Text('${model.minTemp}°C  ',
                      style: const TextStyle(color: Colors.white, fontSize: 14)),
                  const Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.red,
                    size: 18,
                  ),
                  Text('${model.maxTemp}°C',
                      style: const TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ],
          ),

          // const Column(
          //   children: [
          //     Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Icon(
          //           Icons.arrow_upward_rounded,
          //           color: Colors.white,
          //           size: 18,
          //         ),
          //         Text('12',
          //             style: TextStyle(color: Colors.white, fontSize: 14)),
          //       ],
          //     ),
          //     Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Icon(
          //           Icons.arrow_downward_rounded,
          //           color: Colors.white,
          //           size: 18,
          //         ),
          //         Text('12',
          //             style: TextStyle(color: Colors.white, fontSize: 14)),
          //       ],
          //     ),
          //   ],
          // ),

          // Temperature
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.temp.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Text(
                '°C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),

          // weather icon
          Image.asset(
            WeatherModel.getWeatherIcon(model.icon ?? '0'),
            width: 60,
          ),
        ],
      ),
    );
  }
}