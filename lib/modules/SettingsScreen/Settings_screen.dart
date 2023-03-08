import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/comppoents/Componets.dart';
import 'package:shop_app/shared/comppoents/constants.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/State.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var NameController = TextEditingController();
  var EmailController= TextEditingController();
  var PhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {} ,
      builder: (context, state) {

        return ConditionalBuilder(
          condition: AppCubit.get(context).loginModel != null,
          builder: (context)
          {
            var model = AppCubit.get(context).loginModel;
            NameController.text=model!.data!.name!;
            EmailController.text=model!.data!.email!;
            PhoneController.text=model!.data!.phone!;
            return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is UpdateUserLoadingState)
                  const LinearProgressIndicator(),
                  SizedBox(height: 20.0,),
                  defaultFormField(controller: NameController
                      ,
                      type: TextInputType.emailAddress
                      ,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return ' Name Empty ';
                        }
                      }
                      ,
                      label: 'Name'
                      ,
                      prefix: Icons.person),
                  const SizedBox(height: 20.0,),
                  defaultFormField(controller: EmailController,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Email Address is empty';
                        }
                      },
                      label: "Email",
                      prefix: Icons.email),
                  const SizedBox(height: 20.0,),
                  defaultFormField(controller: PhoneController,
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Phone is empty';
                        }
                      },
                      label: "Phone",
                      prefix: Icons.phone),
                  const Spacer(),
                  defaultButton(function: () {
                    if (formKey.currentState!.validate()) {
                      AppCubit.get(context).UserUpdateData(
                          email: EmailController.text
                          , phone: PhoneController.text
                          , name: NameController.text);
                    }
                  }, text: 'Update'),
                  const SizedBox(height: 20.0,),
                  defaultButton(function: () {
                    Signout(context);
                  }, text: 'Logout'),
                  const SizedBox(height: 20.0,)

                ],
              ),
            ),
          );
          },fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );

  }
}
