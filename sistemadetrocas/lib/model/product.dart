import 'package:sistemadetrocas/model/signupUser.dart';

class Product {

   String name;
   String description;
   String productCategory;
   String imagePath;
   int id;
   SignupUser user;

   Product(this.name, this.description, this.productCategory, this.imagePath, {this.id, this.user});

  String get gName => name;
  String get gDesc => description;
  String get gProdCat => productCategory;
  String get gImgPath => imagePath;
  SignupUser get gSignupUser => user;
  int get gProductId => id;

  // Converter o objeto JSON enviado do servidor para o meu modelo
  Product.fromJson(dynamic json) :
    name = json['name'],
    description = json['description'],
    productCategory = json['productCategory'],
    imagePath = json['imageName'],
    id = json['id'],
    user = SignupUser.fromJson(json['user']);

   @override
  String toString() {
    return 'name: '+ gName +' description: ' + gDesc + ' productCategory: ' + gProdCat + ' imagePath: ' + imagePath + ' user: ' + user.toString();
  }

}