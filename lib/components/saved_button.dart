import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherly/services/db/hive_services/hive_service.dart';
import 'package:weatherly/features/dashboard/domain/weather_model.dart';
import 'package:weatherly/features/saved_city/domain/saved_city_model.dart';

class SavedButton extends ConsumerWidget {
  final WeatherModel city;

  const SavedButton({super.key, required this.city});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hiveClient = ref.watch(hiveClientProvider); // Get HiveClient

    return hiveClient.when(
      data: (hive) {
        return IconButton(
          icon: Icon(Icons.bookmark_outline_rounded, size: 25.h),
          onPressed: () async {
            try {
              // Attempt to add the city to favorites
              final status = await hive.addCity(
                SavedCityModel(
                  id: city.id,
                  name: city.name,
                  lat: city.coord?.lat,
                  long: city.coord?.lon,
                ),
              );
              status
                  ? ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('City added to favorites')),
                  )
                  : ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('City already added')),
                  );
            } catch (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error: $e')));
            }
          },
        );
      },
      loading: () {
        return const SizedBox();
      },
      error: (error, stackTrace) {
        return IconButton(
          icon: Icon(Icons.error),
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: $error')));
          },
        );
      },
    );
  }
}
