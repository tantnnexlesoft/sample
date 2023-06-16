import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/core/utils/localization_util.dart';
import 'package:sample/screen/home/home_screen.dart';

import 'core/constant/configuration/main.dart';
import 'core/di/dependence_injection.dart';
import 'core/utils/device_util.dart';
import 'core/widgets/keyboard/dismiss_keyboard.dart';
import 'route/app_router.dart';
import 'route/app_router.gr.dart';
import 'route/common_route_guard.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await registerCommonDependencies();
      await getIt.allReady();
      await registerDependencies();
      await getIt.allReady();
      await EasyLocalization.ensureInitialized();
      final router = AppRouter(GlobalKey<NavigatorState>());

      runApp(EasyLocalization(
        supportedLocales: LocalizationUtil.supportedLocales,
        path: 'lib/core/translations',
        fallbackLocale: LocalizationUtil.defaultLocale,
        startLocale: LocalizationUtil.defaultLocale,
        child: Application(
          router: router,
          // router: getIt<AppRouter>(),
        ),
      ));
    },
    (error, stack) {
      // TODO:
    },
  );
}

class Application extends StatelessWidget {
  final AppRouter router;

  const Application({
    Key? key,
    required this.router,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // print("DATA+TEST: ${router}");
    return LayoutBuilder(builder: (context, constraint) {
      DeviceUtil.initConfigForPlatform(constraint);
      return OrientationBuilder(builder: (context, orientation) {
        DeviceUtil.isLandscapeMode = orientation == Orientation.landscape;
        return DismissKeyboard(child: _createResponsiveMobile(context));
      });
    });
  }

  Widget _createResponsiveMobile(BuildContext context) {
    return ScreenUtilInit(
      designSize: _getDesignSize(),
      minTextAdapt: true,
      // builder: (context, child) {
      builder: () {
        if (ScreenUtil().scaleText < 0.95) {
          DeviceUtil.scaleText =
              sqrt(ScreenUtil().scaleWidth * ScreenUtil().scaleHeight);
        } else {
          DeviceUtil.scaleText = ScreenUtil().scaleText;
        }

        return MaterialApp.router(
          title: kConfigurationAppName,
          debugShowCheckedModeBanner: false,
          routerDelegate: AutoRouterDelegate(router),
          routeInformationParser: router.defaultRouteParser(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          builder: (context, widget) {
            //add this line
            ScreenUtil.setContext(context);
            //return widget!;
            double textScaleFactor = MediaQuery.of(context).textScaleFactor;
            if (textScaleFactor > 2) {
              textScaleFactor = 2;
            }
            if (textScaleFactor > 1) {
              DeviceUtil.textScaleFactor = textScaleFactor;
            } else {
              DeviceUtil.textScaleFactor = 1;
            }
            return LayoutBuilder(builder: (context, constrain) {
              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context)
                    .copyWith(textScaleFactor: textScaleFactor),
                child: widget!,
              );
            });
          },
        );
      },
    );
  }

  Size _getDesignSize() {
    //only apply for mobile view
    if (DeviceUtil.isLandscapeMode) {
      return const Size(1200, 812);
    }
    return const Size(375, 812);
  }
}
