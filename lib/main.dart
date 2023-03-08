import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/homelayout.dart';
import 'package:shop_app/modules/LoginScreen/LoginScreen.dart';
import 'package:shop_app/modules/onboarding/onBoardingScreen.dart';
import 'package:shop_app/shared/comppoents/constants.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/State.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();

  Widget? widget;
  bool onBoarding = false;

  if(CacheHelper.getData(key:'onBoarding') != null){
    onBoarding = CacheHelper.getData(key:'onBoarding');
    if(CacheHelper.getData(key: 'token') != null){
      token = CacheHelper.getData(key: 'token');
      print(token);
      widget = HomeLayout();
    }else widget = LoginScreen();
  }
  else widget = OnBoardingScreen();
  runApp(MyApp(startWidget: widget!));
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  
  final Widget startWidget;
  
  MyApp({required this.startWidget});
  
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..getHomeData()..getCategories()..getUserData()..getFavorites())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: light,
              home: startWidget
          );
        },
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}


