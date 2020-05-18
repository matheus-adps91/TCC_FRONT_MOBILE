class Product {

   String name;
   String description;
   String productCategory;
   String imagePath;

  Product(this.name, this.description, this.productCategory, this.imagePath);

  String get gName => name;
  String get gDesc => description;
  String get gProdCat => productCategory;
  String get gImgPath=> imagePath;

  // Converter o objeto enviado do servidor para o meu do modelo
  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    productCategory = json['productCategory'];
    imagePath = json['imageName'];
   }

   @override
  String toString() {
    return 'name: '+ gName +' description: ' + gDesc + ' productCategory: ' + gProdCat + ' imagePath: ' + imagePath;
  }

}