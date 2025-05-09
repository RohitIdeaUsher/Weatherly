import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherly/features/saved_city/presentation/widgets/saved_city_tile.dart';
import 'package:weatherly/features/saved_city/presentation/provider/saved_city_controller.dart';

class SavedCity extends ConsumerWidget {
  const SavedCity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedCity = ref.watch(savedCityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Saved Cities',
          style: TextStyle(color: Colors.white, fontSize: 22.sp),
        ),
        centerTitle: true,
      ),
      body: savedCity.when(
        data: (cities) {
          return ListView.builder(
            itemCount: cities.length,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: SavedCityTile(
                  model: cities[index],
                  onTap: () {
                    Navigator.pop(context, cities[index].name);
                  },
                  onDelete:
                      () => ref
                          .read(savedCityControllerProvider.notifier)
                          .removeFromFavorite(cities[index].id!),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text('Error: $error'));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
