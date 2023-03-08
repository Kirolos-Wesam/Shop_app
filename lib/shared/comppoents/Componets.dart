
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cubit/Cubit.dart';

void NavigateTo(context, widget) =>
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => widget));

void NavigateAndfinish(context, widget) => Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context) => widget),
        (route) => false);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword=false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled: isClickable,
  onFieldSubmitted: (s){
    onSubmit!(s);
  },
  onChanged:(s) {
    if(onChange==null){
      return;
    }
    onChange!(s);
  },
  onTap: (){
    if(onTap == null ) {
      return;
    }
    onTap!();
  },
  validator: (s){
    return validate(s);
  },
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null?
        IconButton(onPressed: (){suffixPressed!();},
            icon: Icon(suffix))
        : null,
    border: const OutlineInputBorder(),
  ),

);

Widget defaultButton({
  double width=double.infinity,
  Color background=Colors.blue,
  bool isUpperCase=true,
  double radius = 3.0,
  required Function function,
  required String text
}) => Container(width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background
      ),
      child: MaterialButton(
        onPressed: (){function();},
        child: Text(isUpperCase? text.toUpperCase(): text,
        style: const TextStyle(color: Colors.white),),
      ),
);

Widget defaultTextButton({
  required Function function,
  required String text,
}) => TextButton(onPressed: (){function();}, child: Text(text.toUpperCase()));

void ShowToast({
  required String text,
  required ToastStates state
})=> Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ChooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );

enum ToastStates {SUCCESS, ERROR, WARNING}

Color ChooseToastColor(ToastStates state){
  Color color;

  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.yellow;
      break;
  }
  return color;
}

Widget buildListProduct(
    model, context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price!.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice!.toString(),
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          AppCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          AppCubit.get(context).favorites[model.id]! ? Colors.blue : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

