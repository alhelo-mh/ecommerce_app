import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/cubit/cubit.dart';
import 'package:shop_application/layout/cubit/statas.dart';
import 'package:shop_application/models/shop_app/categories_model.dart';
import 'package:shop_application/models/shop_app/home_model.dart';
import 'package:shop_application/shared/components/components.dart';
import 'package:shop_application/shared/styles/colors.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (state.model.status!) {
            showToast(text: state.model.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModle != null,
          builder: (context) => productBuilder(
              ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModle!,
              context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(
          HomeModel model, CategoriesModle categoriesModle, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model.data.banners
                    .map(
                      (e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        height: 150,
                        //fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: categoriesModle.data.data.length,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemBuilder: (context, index) =>
                          buildGridCatogory(categoriesModle.data.data[index]),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Products',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 1 / 1.5,
                children: List.generate(
                    model.data.products.length,
                    (index) =>
                        buildGridProduct(model.data.products[index], context)),
              ),
            ),
          ],
        ),
      );
  Widget buildGridCatogory(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image!),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
            width: 100,
            child: Text(
              model.name!,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );

  Widget buildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 180,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(fontSize: 14, color: defaultColoer),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.old_price.round()}',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.id]!
                                    ? defaultColoer
                                    : Colors.green[200],
                            child: Icon(
                              Icons.favorite_outline,
                              size: 15,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
