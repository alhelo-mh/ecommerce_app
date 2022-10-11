import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/cubit/cubit.dart';
import 'package:shop_application/layout/cubit/statas.dart';
import 'package:shop_application/models/shop_app/Favrites_model.dart';
import 'package:shop_application/shared/components/components.dart';
import 'package:shop_application/shared/styles/colors.dart';

class FavritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          fallback: (context) => Center(child: CircularProgressIndicator()),
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListProduct(
                  ShopCubit.get(context)
                      .favoritsModel!
                      .data!
                      .data![index]
                      .product!,
                  context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount:
                  ShopCubit.get(context).favoritsModel!.data!.data!.length),
        );
      },
    );
  }
}
