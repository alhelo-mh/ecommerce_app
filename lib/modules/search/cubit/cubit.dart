import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/models/shop_app/search_model.dart';
import 'package:shop_application/modules/search/cubit/statas.dart';
import 'package:shop_application/shared/components/constants.dart';
import 'package:shop_application/shared/network/eng_points.dart';
import 'package:shop_application/shared/network/remot/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
