import 'package:shop_app/models/changefavoritesmodel.dart';
import 'package:shop_app/models/loginmodel.dart';

abstract class AppStates {}

class AppInitalState extends AppStates {}

class LoginLoadingState extends AppStates {}

class LoginSucessState extends AppStates {
  final LoginModel loginModel;

  LoginSucessState(this.loginModel);
}

class LoginErrorState extends AppStates {
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends AppStates {}

class ChangeBottomNavState extends AppStates {}

class HomeDataLoadingState extends AppStates {}

class HomeDataSucessState extends AppStates {}

class HomeDataErrorState extends AppStates {}

class CategoriesSucessState extends AppStates {}

class CategoriesErrorState extends AppStates {}

class ChangeFavoritesState extends AppStates {}

class ChangeFavoritesSucessState extends AppStates {
  final ChangeFavoritesModel model;

  ChangeFavoritesSucessState(this.model);
}

class ChangeFavoritesErrorState extends AppStates {}

class FavoritesSucessState extends AppStates {}

class LoadingFavoritesState extends AppStates {}

class FavoritesErrorState extends AppStates {}

class UserDataState extends AppStates {}

class LoadingUserDataState extends AppStates {}

class RegisterLoadingState extends AppStates {}

class RegisterSucessState extends AppStates {
  final LoginModel loginModel;

  RegisterSucessState(this.loginModel);
}
class RegisterErrorState extends AppStates {
  final String error;

  RegisterErrorState(this.error);
}

class UpdateUserLoadingState extends AppStates {}

class UpdateUserSucessState extends AppStates {
  final LoginModel loginModel;

  UpdateUserSucessState(this.loginModel);
}
class UpdateUserErrorState extends AppStates {
  final String error;

  UpdateUserErrorState(this.error);
}



