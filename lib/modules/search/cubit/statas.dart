import 'package:shop_application/models/shop_app/login_model.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {}

class SearchErrorState extends SearchStates {}
