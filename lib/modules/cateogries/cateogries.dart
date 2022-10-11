import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/cubit/cubit.dart';
import 'package:shop_application/layout/cubit/statas.dart';
import 'package:shop_application/models/shop_app/categories_model.dart';

import 'package:shop_application/shared/components/components.dart';

class CateogriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModle!.data.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:
                ShopCubit.get(context).categoriesModle!.data.data.length);
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                model.image!,
              ),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
            )
          ],
        ),
      );
}
