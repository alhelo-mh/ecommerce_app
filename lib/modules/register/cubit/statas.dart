import 'package:shop_application/models/shop_app/login_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterIntialState extends ShopRegisterState {}

class ShopRegisterLoadingState extends ShopRegisterState {}

class ShopRegisterSuccessState extends ShopRegisterState {
  final loginModel model;
  ShopRegisterSuccessState(this.model);
}

class ShopRegisterErrorState extends ShopRegisterState {
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordState extends ShopRegisterState {}
