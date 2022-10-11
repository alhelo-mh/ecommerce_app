import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/cubit/cubit.dart';
import 'package:shop_application/layout/cubit/statas.dart';
import 'package:shop_application/shared/components/components.dart';
import 'package:shop_application/shared/components/constants.dart';

class SettingScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).usreModel;
          nameController.text = model!.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
          return ConditionalBuilder(
            condition: ShopCubit.get(context).usreModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingGetUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'name most not empty';
                          }
                        },
                        label: 'name',
                        prefix: Icons.person),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'email most not empty';
                          }
                        },
                        label: 'email',
                        prefix: Icons.email),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'phone  most not empty';
                          }
                        },
                        label: 'phone',
                        prefix: Icons.phone),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).getUpdateUser(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        },
                        text: 'UPDATE'),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'LOGOUT'),
                  ],
                ),
              ),
            ),
            fallback: (context) => CircularProgressIndicator(),
          );
        });
  }
}
