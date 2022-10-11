import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_application/layout/cubit/cubit.dart';
import 'package:shop_application/shared/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backgrount = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgrount,
      ),
    );
Widget defaultTextButton({
  required Function()? function,
  required String text,
}) =>
    TextButton(onPressed: function, child: Text(text.toUpperCase()));

Widget defaultFormField({
  required TextEditingController controller,
  TextInputType type = TextInputType.visiblePassword,
  Function(dynamic text)? onSubmit,
  // Function? onChange,
  Function()? onTap,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool ispassword = false,
  Function()? suffixPressed,
  Function(dynamic text)? onChange,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: ispassword,
    onChanged: onChange,
    onTap: onTap,
    onFieldSubmitted: onSubmit,
    validator: (value) {
      return validate(value);
    },
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 20),
      prefixIcon: Icon(prefix),

      suffixIcon: suffix != null
          ? IconButton(
              onPressed: suffixPressed,
              icon: Icon(suffix),
            )
          : null,

      // suffixIcon: suffix != null
      //     ? IconButton(
      //         onPressed: suffixPressed!(),
      //         icon: Icon(suffix),
      //       )
      //     : null,
      border: const OutlineInputBorder(),
    ),
  );
}

Widget myDivider() => Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[200],
      ),
    );
void navigateTO(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildListProduct(model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 100,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.image!,
                  ),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                if (model.discount! != 0)
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
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price!.toString(),
                        style: TextStyle(fontSize: 14, color: defaultColoer),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount! != 0)
                        Text(
                          model.oldPrice!.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id!);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.id!]!
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
      ),
    );
