import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherly/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:weatherly/core/location_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await LocationService.checkPermission().then((value) {
      if (value) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: ((context) => const DashBoardScreen()),
              ),
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff060720),
        body: Center(
          child: Text(
            'Weatherly',
            style: TextStyle(color: Colors.white, fontSize: 50.sp),
          ),
        ),
      ),
    );
  }
}
