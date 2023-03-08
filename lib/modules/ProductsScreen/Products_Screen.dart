

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoriesmodel.dart';
import 'package:shop_app/shared/comppoents/Componets.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/State.dart';

import '../../models/homemodel.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is ChangeFavoritesSucessState){
            if(state.model.status == false ){
              ShowToast(text: state.model.message!, state: ToastStates.ERROR);
            }
        }
      },
      builder: (context, state) {
        print( AppCubit.get(context).loginModel == null);
        return ConditionalBuilder(
            condition: AppCubit.get(context).homeModel != null &&  AppCubit.get(context).categoriesmodel != null
            , builder: (context) => builderWidget(AppCubit.get(context).homeModel!, AppCubit.get(context).categoriesmodel!, context)
            , fallback: (context) => const Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget builderWidget(HomeModel model, CategoriesModel categoriesModel, context){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            CarouselSlider(
                items: model.data!.banners.map((e) => Image(
                    image: NetworkImage('${e.image}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                )).toList()
                , options: CarouselOptions(
                height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal
            )), //slider for Ads
          const SizedBox(height: 10.0,),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',
                  style: TextStyle(fontSize: 24.0,
                  fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10.0,),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index) => buildCategories(categoriesModel.data!.data[index]),
                      separatorBuilder: (context,index)=> SizedBox(width: 10.0,),
                      itemCount: categoriesModel.data!.data.length),
                ),
                const SizedBox(height: 10.0,),
                Text('Products',
                  style: TextStyle(fontSize: 24.0,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1/1.58,
                children:
                  List.generate(
                      model.data!.products.length,
                          (index) => buildGridProduct(model.data!.products[index], context))
                ,),
          )

        ],
      ),
    );
  }

  Widget buildCategories(DataModel model) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(image: NetworkImage(model.image!),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.8),
          width: 100.0,
          child: Text(model.name!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white
            ),
          ),
        )
      ],
    );
  }

  Widget buildGridProduct(ProductModel model, context){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                height: 200.0,
              ) , //Image of Products
              if(model.discount != 0)
                Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child:
                const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,

                  ),
                ),
              ) //Discount

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                   model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3
                  ),
                ), //name of product
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue
                      ),
                    ), //price of product
                    const SizedBox(
                      width: 5.0,
                    ),
                    if(model.discount != 0)
                      Text(
                      '${model.oldprice.round()}',
                      style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ), //discount
                      Spacer(),
                      IconButton(onPressed: (){
                          AppCubit.get(context).changeFavorites(model.id!);
                          print(model.id!);
                      },
                          icon: CircleAvatar(
                            backgroundColor: AppCubit.get(context).favorites[model.id]! ? Colors.blue : Colors.grey,
                            radius: 15.0,
                            child: Icon(Icons.favorite_border,size: 14.0,color: Colors.white
                            ),
                          ),)

                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
