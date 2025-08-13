import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_dictionary/core/utils/constent/app_color.dart';
import 'package:my_dictionary/core/utils/constent/app_sizer.dart';
import 'package:my_dictionary/core/utils/constent/logo_path.dart';

import '../../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackGround,
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Image.asset(LogoPath.logo, height: 220.h, width: 240.w),
            Spacer(),
            SpinKitFadingCircle(color: AppColors.secondary),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
