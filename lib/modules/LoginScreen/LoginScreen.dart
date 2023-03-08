import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/homelayout.dart';
import 'package:shop_app/modules/RegisterScreen/RegisterScreen.dart';
import 'package:shop_app/shared/comppoents/Componets.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../shared/comppoents/constants.dart';
import '../../shared/cubit/State.dart';



class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

   var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        if(state is LoginSucessState){
          if(state.loginModel.status == true){
            print(state.loginModel.data?.token);
            CacheHelper.saveData(key: 'token',
                value: state.loginModel.data!.token
            ).then((value) async {
              token=state.loginModel.data!.token!;
              await  AppCubit.get(context).getFavorites();

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
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black),
                      ),
                      Text('login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey)
                      ),
                      SizedBox(height: 40.0,),
                      defaultFormField(controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value){
                            if(value.isEmpty){
                              return 'Please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined),
                      SizedBox(height: 15.0,),
                      defaultFormField(controller: passController,
                          type: TextInputType.visiblePassword,
                          suffix: AppCubit.get(context).suffix,
                          suffixPressed: (){
                          AppCubit.get(context).ChangePasswordVisibility();
                          },
                          isPassword: AppCubit.get(context).isPassword,
                          onSubmit: (value){
                            if(formKey.currentState!.validate()){
                              AppCubit.get(context).userLogin(email: emailController.text,
                                  password: passController.text);
                              print(emailController.text);
                              print(passController.text);
                            }
                          },
                          validate: (String value){
                            if(value.isEmpty){
                              return 'Your Password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline),
                      SizedBox(height: 30.0,),
                      ConditionalBuilder(condition: state is! LoginLoadingState,
                          builder: (context) =>defaultButton(function: (){
                            if(formKey.currentState!.validate()){
                              AppCubit.get(context).userLogin(email: emailController.text,
                                  password: passController.text);
                              print(emailController.text);
                              print(passController.text);
                            }
                          },
                              text: 'login',
                              isUpperCase: true
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()))
                      ,
                      Row(
                        children: [
                          Text('Don\'t have account'),
                          defaultTextButton(function: (){
                            NavigateTo(context,
                                RegisterScreen());
                          },
                              text: 'Register Now')
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
  }
}
