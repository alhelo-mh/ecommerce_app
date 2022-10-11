import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_application/layout/shop_layout.dart';
import 'package:shop_application/modules/login/cubit/cubit.dart';
import 'package:shop_application/modules/login/states/states.dart';
import 'package:shop_application/modules/register/register_screen.dart';
import 'package:shop_application/shared/components/components.dart';
import 'package:shop_application/shared/components/constants.dart';
import 'package:shop_application/shared/network/local/ccch_helper.dart';

class Login extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (BuildContext context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.model.status!) {
              CacheHelper.saveData(key: 'token', value: state.model.data!.token)
                  .then((value) {
                token = state.model.data!.token!;
                navigateAndFinish(context, ShopLayout());
              });
              showToast(text: state.model.message!, state: ToastStates.SUCCESS);
            } else {
              showToast(text: state.model.message!, state: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, state) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'login now to browse',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const SizedBox(height: 20),
                        defaultFormField(
                          controller: emailController,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Email must be empty';
                            }
                            return null;
                          },
                          label: 'Email',
                          prefix: Icons.email,
                          type: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        defaultFormField(
                          controller: passwordController,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password must be empty';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: ShopLoginCubit.get(context).suffix,
                          ispassword: ShopLoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopLoginCubit.get(context).changrPasswordSuffix();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          type: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 20),
                        defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: 'login',
                          radius: 20,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an accont'),
                            defaultTextButton(
                                function: () {
                                  navigateTO(context, RegisterScreen());
                                },
                                text: 'register'),
                          ],
                        )
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
