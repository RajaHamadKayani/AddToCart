import 'dart:io';

import 'package:add_to_cart_api/cart_screen/cart_screen.dart';
import 'package:add_to_cart_api/flutter_toast/flutter_toast.dart';
import 'package:add_to_cart_api/model_class/fake_api_photos_model_class.dart';
import 'package:add_to_cart_api/utils/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<MyFakeApiPhotosModelClass> selectedItems = [];
String url = "https://reqres.in/api/login";

class HomeScreenStateMangement with ChangeNotifier {
  void dispose() {
    super.dispose();
  }

  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool value) {
    _loading = value;
  }

  bool isValidate(String email, String password) {
    if (email.trim().isEmpty) {
      return Message.showToast("Email field can not be empty!!!");
    } else if (password.trim().isEmpty) {
      return Message.showToast("Password field can not be empty!!!");
    }
    return true;
  }

  Future signIn(BuildContext context, String email, String password) async {
    try {
      await http.post(Uri.parse(url),
          body: {"email": email, "password": password}).then((value) {
        Message.showToast("Sign In Successfully!!!!");
        Navigator.pushNamed(context, RouteNames.homePageRoute);
      }).onError((error, stackTrace) {
        Message.showToast(error.toString());
      });
      // ignore: unused_catch_clause
    } on HttpException catch (error) {
      String? errorMessage;
      if (errorMessage.toString().contains("INVALID_EMAIL")) {
        errorMessage = "Invalid email";
        print(errorMessage.toString());
        Message.showToast(errorMessage);
      } else if (errorMessage.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "Invalid Password";
        print(errorMessage);
        Message.showToast(errorMessage);
      }
    } catch (e) {
      Message.showToast(e.toString());
    }
  }

  Future addDatatoCartScreen(
      MyFakeApiPhotosModelClass myFakeApiPhotosModelClass) async {
    try {
      setLoading(true);

      if (!selectedItems.contains(myFakeApiPhotosModelClass)) {
        selectedItems.add(myFakeApiPhotosModelClass);
        Message.showToast("Add to cart successfully!!!");
        setLoading(false);
        notifyListeners();
      }
    } catch (e) {
      setLoading(false);
      Message.showToast(e.toString());
    }
  }

  navigateToCartScreen(BuildContext context) {
    setLoading(true);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyCartScreen(selectedItems: selectedItems)));
    Message.showToast("Navigated to Cart Successfully");
    setLoading(false);
  }

  removeItemsFromCart(MyFakeApiPhotosModelClass modelClass) {
    setLoading(true);
    if (selectedItems.contains(modelClass)) {
      selectedItems.remove(modelClass);
      Message.showToast("Item Removed Successfully");
      setLoading(false);
      notifyListeners();
    }
  }
}
