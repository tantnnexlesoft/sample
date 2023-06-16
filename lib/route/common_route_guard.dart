import 'package:auto_route/auto_route.dart';

class CommonRouteGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    return resolver.next(true);
  }
}
