import 'package:add_to_cart_api/cart_screen/cart_screen.dart';
import 'package:add_to_cart_api/home_screen/home_screen.dart';
import 'package:add_to_cart_api/login/login.dart';
import 'package:add_to_cart_api/model_class/fake_api_photos_model_class.dart';
import 'package:add_to_cart_api/utils/routes/route_names.dart';
import 'package:flutter/material.dart';

List<MyFakeApiPhotosModelClass> selectedItems = [];

class AppRoutes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homePageRoute:
        return MaterialPageRoute(builder: (context) => MyHomeScreen());
      case RouteNames.cartScreenRoute:
        return MaterialPageRoute(
            builder: (context) => MyCartScreen(selectedItems: selectedItems));
      case RouteNames.loginScreenRoute:
        return MaterialPageRoute(builder: (_) => MyLoginScreen());
      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Container(
              child: Text("No routes defined for ${settings.name}"),
            ),
          );
        });
    }
  }
}
