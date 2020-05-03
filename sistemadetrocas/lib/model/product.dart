class Product {

  final String name;
  final String description;
  final String productCategory;
  final String imageFileName;
  final String base64Image;


  Product(this.name, this.description, this.productCategory,
      {this.imageFileName = 'Sem nome', this.base64Image = 'Sem foto'});

  String get gName => name;
  String get gDesc => description;
  String get gProdCat => productCategory;
  String get gImgFileName => imageFileName;
  String get gImage => base64Image;

}