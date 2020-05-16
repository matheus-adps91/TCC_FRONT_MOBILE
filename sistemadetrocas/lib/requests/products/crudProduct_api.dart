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
      ServerConfigurations.get_all_my_product_url,headers: headers
    );

    // API me devolve uma lista de Products por isso pego usando LIST
    // Lista dinâmica, converter para uma de carros
    final List dynamicList = convert.json.decode(response.body);
    print (dynamicList);
    final List<Product> products = _convertDynamicToTypedList(dynamicList);
    return products;
  }

  static List<Product> _convertDynamicToTypedList(List dynamicList) {
    final List<Product> products = List<Product>();
    for (Map currentMap in dynamicList ) {
      Product product = Product.fromJson(currentMap);
      products.add(product);
    }
    return products;
  }
}