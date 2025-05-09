import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizedBoxExtension on num {
  SizedBox get sbW => SizedBox(width: w);
  SizedBox get sbH => SizedBox(height: h);
}
