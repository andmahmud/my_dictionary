import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/cupertino.dart';
import 'package:my_dictionary/core/utils/constent/app_sizer.dart';
import 'package:my_dictionary/core/utils/constent/app_sizes.dart';
import 'package:my_dictionary/core/utils/theme/theme.dart';
import 'package:my_dictionary/routes/app_routes.dart';
import 'core/bindings/controller_binder.dart';
import 'package:get/get.dart';

class PlatformUtils {
  static bool get isIOS =>
      foundation.defaultTargetPlatform == TargetPlatform.iOS;
  static bool get isAndroid =>
      foundation.defaultTargetPlatform == TargetPlatform.android;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.init,
          getPages: AppRoute.routes,
          initialBinding: ControllerBinder(),
          themeMode: ThemeMode.system,
          theme: _getLightTheme(),
          darkTheme: _getLightTheme(),
          defaultTransition:
              PlatformUtils.isIOS ? Transition.cupertino : Transition.fade,
          locale: Get.deviceLocale,
          builder:
              (context, child) =>
                  PlatformUtils.isIOS
                      ? CupertinoTheme(
                        data: const CupertinoThemeData(),
                        child: child!,
                      )
                      : child!,
        );
      },
    );
  }

  ThemeData _getLightTheme() {
    return PlatformUtils.isIOS
        ? AppTheme.lightTheme.copyWith(platform: TargetPlatform.iOS)
        : AppTheme.lightTheme;
  }

  // ignore: unused_element
  ThemeData _getDarkTheme() {
    return PlatformUtils.isIOS
        ? AppTheme.darkTheme.copyWith(platform: TargetPlatform.iOS)
        : AppTheme.darkTheme;
  }
}
