import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoriesmodel.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/State.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state){
        return ListView.separated(
            itemBuilder: (context, index)=> buildCatitem(AppCubit.get(context).categoriesmodel!.data!.data[index]),
            separatorBuilder: (context,index)=> Divider(),
            itemCount: AppCubit.get(context).categoriesmodel!.data!.data.length);
      },
    );
  }

  Widget buildCatitem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(model.image!),
          height: 80.0,
          width: 80.0,
        ),
        SizedBox(width: 20.0,),
        Text(model.name!,
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold
          ),),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
