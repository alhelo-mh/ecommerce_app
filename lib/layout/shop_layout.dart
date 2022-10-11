import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/cubit/cubit.dart';
import 'package:shop_application/layout/cubit/statas.dart';
import 'package:shop_application/modules/login/login.dart';
import 'package:shop_application/modules/search/search.dart';
import 'package:shop_application/shared/components/components.dart';
import 'package:shop_application/shared/network/local/ccch_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('SHOP'),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTO(context, SearchScreen());
                },
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                cubit.changeBottom(value);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'category'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'settings'),
              ]),
        );
      },
    );
  }
}
