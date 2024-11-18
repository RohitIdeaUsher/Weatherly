import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weatherly/components/weekly_forecast_tile.dart';
import 'package:weatherly/features/dashboard/domain/forecast_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WeeklyForecastTile Tests', () {
    testWidgets('should display correct weather details', (tester) async {
      final forecastModel = ForecastModel(
        date: '2024-11-18T00:00:00Z',
        minTemp: '10',
        maxTemp: '20',
        temp: '15',
        icon: '01d',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScreenUtilInit(
              designSize: const Size(375, 812),
              builder: (context, child) =>
                  WeeklyForecastTile(model: forecastModel),
            ),
          ),
        ),
      );

      expect(find.text('Monday'), findsOneWidget);
      expect(find.text('18 November 2024'), findsOneWidget);
    });
  });
}
