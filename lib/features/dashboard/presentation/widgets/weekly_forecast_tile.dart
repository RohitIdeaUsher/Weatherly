import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weatherly/features/dashboard/domain/forecast_model.dart';
import 'package:weatherly/features/dashboard/domain/weather_model.dart';
import 'package:weatherly/core/sized_box_extension.dart';

class WeeklyForecastTile extends StatelessWidget {
  const WeeklyForecastTile({super.key, required this.model});

  final ForecastModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('EEEE').format(DateTime.parse(model.date!)),

                style: const TextStyle(fontSize: 20),
              ),
              5.sbH,
              Text(
                DateFormat('dd MMMM yyyy').format(DateTime.parse(model.date!)),
                style: const TextStyle(fontSize: 14),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_downward_rounded,
                    color: Colors.green,
                    size: 18.h,
                  ),
                  Text(
                    '${model.minTemp}°C  ',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.red,
                    size: 18.h,
                  ),
                  Text(
                    '${model.maxTemp}°C',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.temp.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Text(
                '°C',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
            ],
          ),

          SvgPicture.asset(
            WeatherModel.getWeatherIconSvg(model.icon ?? '0'),
            width: 60.w,
          ),
        ],
      ),
    );
  }
}
