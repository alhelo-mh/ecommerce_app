import 'package:shop_application/models/shop_app/login_model.dart';

abstract class ShopLoginState {}

class ShopLoginIntialState extends ShopLoginState {}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  final loginModel model;
  ShopLoginSuccessState(this.model);
}

class ShopLoginErrorState extends ShopLoginState {
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopChangePasswordState extends ShopLoginState {}
