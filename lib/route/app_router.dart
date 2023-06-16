// ignore_for_file: cast_nullable_to_non_nullable, prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../screen/home/home_screen.dart';
import 'common_route_guard.dart';
import 'route_path.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen|Page|View,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomeScreen,
      path: RoutePath.homeScreen,
      initial: true,
    ),
  ],
)

class $AppRouter {}


// class AppRouter extends _$AppRouter {
//   AppRouter(
//     GlobalKey<NavigatorState> globalKey,
//   ) : super(navigatorKey: globalKey,);
// }
