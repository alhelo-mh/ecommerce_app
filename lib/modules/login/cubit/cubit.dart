import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/models/shop_app/login_model.dart';
import 'package:shop_application/modules/login/states/states.dart';
import 'package:shop_application/shared/network/eng_points.dart';
import 'package:shop_application/shared/network/remot/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginIntialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel loginModelData;
      loginModelData = loginModel.formJson(value.data);
      print(loginModelData.message);
      print(loginModelData.data!.email);
      emit(ShopLoginSuccessState(loginModelData));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changrPasswordSuffix() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordState());
  }
}
