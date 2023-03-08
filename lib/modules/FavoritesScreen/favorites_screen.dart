import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favoritesmodel.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/State.dart';

import '../../shared/comppoents/Componets.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>
      (
      listener: (context , state) {},
      builder: (context, state) {
         return ConditionalBuilder(
           condition: state is! LoadingFavoritesState,
           builder: (context) => ListView.separated(itemBuilder: (context, index) => buildListProduct(AppCubit.get(context).favoritesModel!.data!.data![index].product!, context)
               , separatorBuilder: (context, index)=> const Divider() ,
               itemCount: AppCubit.get(context).favoritesModel!.data!.data.length),
           fallback: (context) => const Center(child: CircularProgressIndicator()),
         );
      },
    );
  }

}
