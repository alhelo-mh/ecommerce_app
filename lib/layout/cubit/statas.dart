import 'package:shop_application/models/add_favorites_model.dart';
import 'package:shop_application/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLodingHomeState extends ShopStates {}

class ShopSuccessHomeState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccesscategoriesState extends ShopStates {}

class ShopErrorcategoriesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final AddFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final loginModel loginModelShop;

  ShopSuccessGetUserDataState(this.loginModelShop);
}

class ShopErrorGetUserDataState extends ShopStates {}

class ShopLoadingGetUpdateUserState extends ShopStates {}

class ShopSuccessGetUpdateUserState extends ShopStates {
  final loginModel loginModelShop;

  ShopSuccessGetUpdateUserState(this.loginModelShop);
}

class ShopErrorGetUpdateUserState extends ShopStates {}
