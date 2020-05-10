import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:sistemadetrocas/infrastructure/api_entityResponse.dart';
import 'package:sistemadetrocas/model/product.dart';
import 'package:sistemadetrocas/serverConfigurations/server_configuration.dart';
import 'package:sistemadetrocas/utils/prefs.dart';

class CrudProduct {

  static Future<ApiEntityResponse<bool>> create(Product product) async {
    String token = await Prefs.getString('token');
    Map<String,String> headers = {
      "Content-Type": "application/json",
      "token": token
    };
    Map params = {
      'name': product.gName,
      'description': product.gDesc,
      'productCategory': product.gProdCat,
      'imagePath': product.gImgPath
    };
    // Para enviar o cabeçalho em formato JSON, deve converter o MAP para STRING
    String sParams = convert.json.encode(params);
    var response = await http.post(
        ServerConfigurations.create_product_url,
        body: sParams, headers: headers
    );

    print(response.headers.toString());
    print(response.statusCode.toString());

    if ( response.statusCode == 201 ) {
      print('STATUS CODE 200');
      return ApiEntityResponse.success(true);
    }
    return ApiEntityResponse.fail(false);
  }

  static Future<List<Product>> getProducts()  async {
    String token = await Prefs.getString('token');
    Map<String,String> headers = {
      "Content-Type": "application/json",
      "token": token
    };
    var response = await http.get(
      ServerConfigurations.get_all_product_url,headers: headers
    );
    String json = response.body;
    Product p1 = Product('teste1','teste desc','Memoria');
    Product p2 = Product('teste2','teste desc','Memoria');
    Product p3 = Product('teste3','teste desc','Memoria');
    Product p4 = Product('teste4','teste desc','Memoria');
    List<Product> products = List<Product>();
    products.add(p1);
    products.add(p2);
    products.add(p3);
    products.add(p4);
    return products;
  }
}