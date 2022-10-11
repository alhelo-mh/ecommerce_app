import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/cubit/cubit.dart';
import 'package:shop_application/layout/shop_layout.dart';
import 'package:shop_application/modules/login/login.dart';
import 'package:shop_application/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_application/shared/bloc_observer.dart';
import 'package:shop_application/shared/components/constants.dart';
import 'package:shop_application/shared/cubit/states.dart';
import 'package:shop_application/shared/network/local/ccch_helper.dart';
import 'package:shop_application/shared/network/remot/dio_helper.dart';
import 'package:shop_application/shared/styles/themes.dart';

import 'shared/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.inti();
  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = Login();
  } else {
    widget = OnBoardingScreen();
  }

  print(token);
  runApp(MyApp(widget, isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget StarWidget;

  MyApp(this.StarWidget, this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromIsDark: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: StarWidget,
            );
          }),
    );
  }
}
