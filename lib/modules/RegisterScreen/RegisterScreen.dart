import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/comppoents/Componets.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/State.dart';

import '../../layout/homelayout.dart';
import '../../shared/comppoents/constants.dart';
import '../../shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var NameController= TextEditingController();
  var EmailController= TextEditingController();
  var PasswordController= TextEditingController();
  var PhoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is RegisterSucessState){
          if(state.loginModel.status == true){
            print(state.loginModel.data?.token);
            CacheHelper.saveData(key: 'token',
                value: state.loginModel.data!.token
            ).then((value) {
              token=state.loginModel.data!.token!;
              NavigateAndfinish(context, HomeLayout());
            });
            ShowToast(text: state.loginModel.message!,
                state: ToastStates.SUCCESS);

          }else{
            ShowToast(text: state.loginModel.message!,
                state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {return Scaffold(
        appBar: AppBar(
          ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('REGISTER',
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.black),
                    ),
                    Text('Register now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey)
                    ),
                    SizedBox(height: 20.0,),
                    defaultFormField(controller: NameController
                        , type: TextInputType.name
                        , validate: (String value){
                          if(value.isEmpty){
                            return 'Please enter Name ';
                          }
                        }
                        , label: 'User Name'
                        , prefix: Icons.person_add),
                    SizedBox(height: 20.0,),
                    defaultFormField(controller: EmailController
                        , type: TextInputType.emailAddress
                        , validate: (String value){
                          if(value.isEmpty){
                            return 'Please enter Email Address ';
                          }
                        }
                        , label: 'Email Address'
                        , prefix: Icons.email),
                    SizedBox(height: 20.0,),
                    defaultFormField(controller: PasswordController
                      , type: TextInputType.visiblePassword
                      , validate: (String value){
                        if(value.isEmpty){
                          return 'Please enter Password';
                        }
                      }
                      , label: 'Password'
                      , prefix: Icons.password
                      , suffix: AppCubit.get(context).suffix
                      ,suffixPressed: () { AppCubit.get(context).ChangePasswordVisibility(); }
                      ,isPassword: AppCubit.get(context).isPassword
                    ),
                    SizedBox(height: 20.0,),
                    defaultFormField(controller: PhoneController
                        , type: TextInputType.phone
                        , validate: (String value){
                          if(value.isEmpty){
                            return 'Please enter your phone Number';
                          }
                        }
                        , label: 'Phone Number'
                        , prefix: Icons.phone),
                    SizedBox(height: 20.0,),
                    ConditionalBuilder(
                      condition: state is! RegisterLoadingState,
                      builder: (context) => defaultButton(function: (){
                        if(formKey.currentState!.validate()){
                          AppCubit.get(context).userRegister(email: EmailController.text
                              , password: PasswordController.text
                              , phone: PhoneController.text
                              , name: NameController.text);
                        }
                      },
                          text: 'Register', isUpperCase: true) ,
                      fallback: (context) => CircularProgressIndicator(),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      );} ,
    );
  }
}
