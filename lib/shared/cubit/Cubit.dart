import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/homelayout.dart';
import 'package:shop_app/models/categoriesmodel.dart';
import 'package:shop_app/models/changefavoritesmodel.dart';
import 'package:shop_app/models/favoritesmodel.dart';
import 'package:shop_app/models/homemodel.dart';
import 'package:shop_app/models/loginmodel.dart';
import 'package:shop_app/modules/CategoriesScreen/categories_screen.dart';
import 'package:shop_app/modules/FavoritesScreen/favorites_screen.dart';
import 'package:shop_app/modules/ProductsScreen/Products_Screen.dart';
import 'package:shop_app/modules/SearchScreen/Search_screen.dart';
import 'package:shop_app/modules/SettingsScreen/Settings_screen.dart';
import 'package:shop_app/shared/cubit/State.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../comppoents/constants.dart';
import '../network/endpoints.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitalState());

  static AppCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  
  void userLogin({
  required String email,
    required String password
}){
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN
        , data: {
      'email':email,
      'password':password,
    }).then((value) async{
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSucessState(loginModel!));
    }).catchError((onError){
      print(onError);
    });
  }  // User Login Mail and Password

  IconData suffix= Icons.visibility_outlined;
  bool isPassword= true;
  void ChangePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  } // Eye Icon


  int currentindex = 0;

  List<Widget> BottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
  FavoritesScreen(),
  SettingsScreen()]; // List of Switch Screen

  void changeBottom(int index){
    currentindex= index;
    emit(ChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData(){
    emit(HomeDataLoadingState());

    DioHelper.getData(url: HomeData, token: token)
        .then((value) {
          homeModel=HomeModel.fromJson(value.data);
        //printFullText(homeModel!.data!.banners[0].image!);
         //print(homeModel?.status);

         homeModel!.data!.products.forEach((element) {

           favorites.addAll({
            element.id!: element.InFavorites!,
           });
         });
         print(favorites.toString());
          emit(HomeDataSucessState());
    });
  } //Main Data from the model or Api

  CategoriesModel? categoriesmodel;

  void getCategories(){
    DioHelper.getData(url: GET_categories)
        .then((value) {
      categoriesmodel=CategoriesModel.fromJson(value.data);

      emit(CategoriesSucessState());
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int Productid){

    favorites[Productid] = !favorites[Productid]!;
    emit(ChangeFavoritesState());
    DioHelper.postData(url: FAVORITES,
        data: {'product_id': Productid},
      token: token)
        .then((value) {
          changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
          print(value.data);

          if(changeFavoritesModel!.status==false){
            favorites[Productid] = !favorites[Productid]!;
          }else{
            getFavorites();
          }

          emit(ChangeFavoritesSucessState(changeFavoritesModel!));
    })
        .catchError((error){

        favorites[Productid] = !favorites[Productid]!;
        emit(ChangeFavoritesErrorState());
    });
  }


  FavoritesModel? favoritesModel;
  Future<void> getFavorites() async{
    if(token.trim() == ''){
      return;
    }
    emit(LoadingFavoritesState());
    await DioHelper.getData(url: FAVORITES, token: token)
        .then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(FavoritesSucessState());
    });
  }

  //LoginModel? UserData;
  Future<void> getUserData() async{
    if(token.trim() == ''){
      return;
    }
    await DioHelper.getData(url: PROFILE, token: token)
        .then((value) {
      loginModel =LoginModel.fromJson(value.data);
      emit(UserDataState());
    });
  }

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER
        , data: {
          'email':email,
          'password':password,
          'phone': phone,
          'name': name
        }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSucessState(loginModel!));
    });
  }

  void UserUpdateData({
    required String email,
    required String phone,
    required String name
  }){
    emit(UpdateUserLoadingState());
    DioHelper.putData(url: update_profile
        , data: {
          'email':email,
          'phone': phone,
          'name': name
        }, token: token).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(UpdateUserSucessState(loginModel!));
    });
  }



}