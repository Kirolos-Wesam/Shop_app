class HomeModel{
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json){
    status= json['status'];
    data=HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel{
 List<BannersModel> banners = [];
 List<ProductModel> products = [];

 HomeDataModel.fromJson(Map<String, dynamic> json){
   json['banners'].forEach((element){
     banners.add(BannersModel.fromJson(element));
   });
   json['products'].forEach((element){
     products.add(ProductModel.fromJson(element));
   }
   );
 }
}

class BannersModel{

  int? id;
  String? image;

  BannersModel.fromJson(Map<String, dynamic> json){
    id=json['id'];
    image=json['image'];
  }
}

class ProductModel{
  int? id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  String? image;
  String? name;
  bool? InFavorites;
  bool? InCart;
  ProductModel.fromJson(Map<String, dynamic> json){
    id=json['id'];
    price=json['price'];
    oldprice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    InFavorites=json['in_favorites'];
    InCart=json['in_cart'];
  }
}

