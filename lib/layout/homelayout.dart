import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/LoginScreen/LoginScreen.dart';
import 'package:shop_app/modules/SearchScreen/Search_screen.dart';
import 'package:shop_app/shared/comppoents/Componets.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/State.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';


// Home Layout for Screens of Application
class HomeLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            title: Text('Super Mart'),
            actions: [
              IconButton(onPressed: (){
                NavigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search))
            ],
          ),
          body: cubit.BottomScreens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentindex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.production_quantity_limits_sharp),
                  label: 'Home' ),
              BottomNavigationBarItem(icon: Icon(Icons.apps),
              label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),
              label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings,),
              label: 'Settings')
            ],
          ),
        );
      },

    );
  }
}
