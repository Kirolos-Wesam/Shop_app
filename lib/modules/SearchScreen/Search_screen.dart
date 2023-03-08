import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/SearchScreen/cubit/cubit.dart';
import 'package:shop_app/modules/SearchScreen/cubit/states.dart';
import 'package:shop_app/shared/comppoents/Componets.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var SearchConttroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit() ,
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text('Search Screen'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormField(controller: SearchConttroller
                    , type: TextInputType.text
                    , validate: (String value){
                      if(value.isEmpty){
                        return 'Search is empty';
                      }
                    }
                    , label: 'Search'
                    , prefix: Icons.search
                    , onSubmit: (String text){
                      SearchCubit.get(context).search(text);
                    }),
                SizedBox(height: 20.0,),
                if(state is SearchLoadingState)
                  LinearProgressIndicator(),
                SizedBox(height: 20.0,),
                if(state is SearchSuccessState)
                  Expanded(
                  child: ListView.separated(itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model!.data!.data![index], context,isOldPrice: false)
                      , separatorBuilder: (context, index)=> const Divider() ,
                      itemCount: SearchCubit.get(context).model!.data!.data.length),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
