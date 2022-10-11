import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/models/shop_app/login_model.dart';
import 'package:shop_application/modules/login/states/states.dart';
import 'package:shop_application/modules/register/cubit/statas.dart';
import 'package:shop_application/shared/network/eng_points.dart';
import 'package:shop_application/shared/network/remot/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterIntialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String? email,
    required String? password,
    required String? name,
    required String? phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      loginModel loginModelData;
      loginModelData = loginModel.formJson(value.data);
      print(loginModelData.message);
      print(loginModelData.data!.email);
      emit(ShopRegisterSuccessState(loginModelData));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changrPasswordSuffix() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordState());
  }
}
