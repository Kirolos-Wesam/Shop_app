import 'package:flutter/material.dart';
import 'package:shop_app/shared/comppoents/Componets.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../modules/LoginScreen/LoginScreen.dart';

void Signout (context){
    CacheHelper.removeData(key: 'token')
        .then((value) {
      if(value){
        NavigateAndfinish(context, LoginScreen());
      }
    });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}

String token = '';