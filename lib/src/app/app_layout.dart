import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaf_app/src/app/di_service.dart';
import 'package:kaf_app/src/core/services/prefs_service.dart';
import 'package:kaf_app/src/core/utils/app_colors.dart';
import 'package:kaf_app/src/core/utils/app_theme.dart';
import 'package:kaf_app/src/modules/products_screen/presentation/ui/products_screen.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      useOnlyLangCode: true,
      startLocale: Locale(di<PrefsService>().locale.get()),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          title: 'Security Zawahid',
          theme: ThemeData(
            fontFamily: 'Cairo',
            sliderTheme: const SliderThemeData(
              showValueIndicator: ShowValueIndicator.always,
              thumbColor: AppColors.lightGreen,
            ),
            primaryColor: AppColors.black,
            radioTheme: RadioThemeData(
              fillColor: WidgetStateProperty.all(AppColors.black),
            ),
            scaffoldBackgroundColor: AppColors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.white,
              elevation: 0,
              titleTextStyle: AppTheme.textTheme.displayLarge,
              centerTitle: true,
              toolbarTextStyle:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
              foregroundColor: AppColors.white,
            ),
          ),
          home: const ProductsScreen(),
        ),
      ),
    );
  }
}
