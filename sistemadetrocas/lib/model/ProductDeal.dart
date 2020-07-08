import 'package:sistemadetrocas/model/product.dart';

class ProductDeal
{
  Product productProponent;
  Product productProposed;
  int idDeal;
  int id;

  ProductDeal(
      this.productProponent,
      this.productProposed,
      this.idDeal,
      this.id);

  Product get gProductProponent => productProponent;
  Product get gProductProposed => productProposed;
  int get gIdDeal => idDeal;
  int get gId => id;

  // Converter o objeto JSON recebido para o meu modelo
  ProductDeal.fromJson(dynamic json) :
      productProponent = Product.fromJson(json['productProponent']),
      productProposed =  Product.fromJson(json['productProposed']),
      idDeal = json['idDeal'],
      id = json['id'];

  @override
  String toString() {
    return '{id: '+ gId.toString() +' productProponent:  '+ gProductProponent.toString();
  }
}