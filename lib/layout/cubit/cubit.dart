import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/cubit/statas.dart';
import 'package:shop_application/models/add_favorites_model.dart';
import 'package:shop_application/models/shop_app/categories_model.dart';
import 'package:shop_application/models/shop_app/home_model.dart';
import 'package:shop_application/models/shop_app/login_model.dart';
import 'package:shop_application/modules/cateogries/cateogries.dart';
import 'package:shop_application/modules/favorites/favrites.dart';
import 'package:shop_application/modules/login/states/states.dart';
import 'package:shop_application/modules/products/products_screen.dart';
import 'package:shop_application/modules/setting/setting.dart';
import 'package:shop_application/shared/components/constants.dart';
import 'package:shop_application/shared/network/eng_points.dart';
import 'package:shop_application/shared/network/remot/dio_helper.dart';

import '../../models/shop_app/Favrites_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductScreen(),
    CateogriesScreen(),
    FavritesScreen(),
    SettingScreen()
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopLodingHomeState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel!.data.banners[1].image.toString());

      print(homeModel!.data.banners[0].id);
      homeModel!.data.products.forEach(
        (element) {
          favorites.addAll({
            element.id: element.in_favorites,
          });
        },
      );
      print(favorites.toString());
      emit(ShopSuccessHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModle? categoriesModle;
  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModle = CategoriesModle.fromJson(value.data);
      print(categoriesModle!.data.data[0].id);
      emit(ShopSuccesscategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorcategoriesState());
    });
  }

  AddFavoritesModel? addFavoritsModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVRITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      addFavoritsModel = AddFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!addFavoritsModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(addFavoritsModel!));
    }).catchError((error) {
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavritesModel? favoritsModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVRITES,
      token: token,
    ).then((value) {
      favoritsModel = FavritesModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  loginModel? usreModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      usreModel = loginModel.formJson(value.data);
      print(usreModel!.data!.name);
      emit(ShopSuccessGetUserDataState(usreModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }

  void getUpdateUser({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingGetUpdateUserState());
    DioHelper.putData(url: UPDATE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      usreModel = loginModel.formJson(value.data);
      print(usreModel!.data!.name);
      emit(ShopSuccessGetUpdateUserState(usreModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUpdateUserState());
    });
  }
}
