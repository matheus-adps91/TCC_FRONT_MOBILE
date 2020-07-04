import 'package:sistemadetrocas/model/signupUser.dart';

class Product {

   String name;
   String description;
   String productCategory;
   bool dealing;
   String imagePath;
   int id;
   SignupUser user;

   Product(
       this.name,
       this.description,
       this.productCategory,
       this.dealing,
       this.imagePath,
       {this.id, this.user});

  String get gName => name;
  String get gDesc => description;
  String get gProdCat => productCategory;
  bool get gDealing => dealing;
  String get gImgPath => imagePath;
  SignupUser get gSignupUser => user;
  int get gProductId => id;

  // Converter o objeto JSON enviado do servidor para o meu modelo
  Product.fromJson(dynamic json) :
    name = json['name'],
    description = json['description'],
    productCategory = json['productCategory'],
    dealing = json['dealing'],
    imagePath = json['imageName'],
    id = json['id'],
    user = SignupUser.fromJson(json['user']);

   @override
  String toString() {
    return '{name: '+ gName +' description: ' + gDesc + ' productCategory: ' + gProdCat + ' dealing: '+ gDealing.toString() + ' imagePath: ' + gImgPath + ' user: ' + user.toString() +' }';
  }

}