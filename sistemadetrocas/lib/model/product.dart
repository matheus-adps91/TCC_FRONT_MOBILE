class Product {

   String name;
   String description;
   String productCategory;
   String imagePath;

  Product(this.name, this.description, this.productCategory,
      {this.imagePath = 'Sem Imagem'});

  String get gName => name;
  String get gDesc => description;
  String get gProdCat => productCategory;
  String get gImgPath=> imagePath;

}