import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:sistemadetrocas/infrastructure/api_entityResponse.dart';
import 'package:sistemadetrocas/model/product.dart';
import 'package:sistemadetrocas/requests/storage/fire_storage_service.dart';
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

    print (response.body);
    dynamic productsParsed = convert.json.decode(response.body);
    List<Product> products = _convertDynamicToTypedList(productsParsed);
    return products;
  }

  static List<Product> _convertDynamicToTypedList(productsParsed) {
    final List<Product> products = List<Product>();
    for (dynamic currentProduct in productsParsed ) {
      Product product = Product.fromJson(currentProduct);
      products.add(product);
    }
    return products;
  }

  static Future<ApiEntityResponse<bool>> deleteProduct(Product product) async {
    print('>>> Dento da função deleteProduct');
    print(product);
    String token = await Prefs.getString('token');
    Map<String,String> headers = {
      "Content-Type": "application/json",
      "token": token
    };
    var response = await http.delete(
      ServerConfigurations.delete_product_url+product.gName, headers: headers
    );
    print(response.headers.toString());
    print(response.statusCode.toString());

    if ( response.statusCode == 200 ) {
      FireStorageService.deleteImageFromStorage(product.gImgPath);
    }
  }

  static void updateProduct(Product product, String cacheProductName, String cacheImgPath) async {
    print('>>> Dentro da função updateProduct');
    print(product);
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
    var response = await http.put(
      ServerConfigurations.update_product_url+cacheProductName, headers: headers, body: sParams
    );
    print(response.headers.toString());
    print(response.statusCode.toString());
    
    if ( response.statusCode == 200 ) {
      if ( cacheImgPath != product.gImgPath) {
        FireStorageService.deleteImageFromStorage(cacheImgPath);
      }
    }
  }

  static Future<List<Product>> getProductByName(String productName) async {
    String token = await Prefs.getString('token');
    Map<String,String> headers = {
      "Content-Type": "application/json",
      "token": token
    };
    var response = await http.get(
      ServerConfigurations.get_product_by_name+productName, headers: headers
    );
    if ( response.statusCode == 404 ) {
      return List<Product>();
    }
    print (response.body);
    var productsDecoded = convert.json.decode(response.body);
    List<Product> products = _convertVarToTypedList(productsDecoded);
    return products;
  }

  static Future<List<Product>> getProductByCategory(String dropdownValue) async {
    String token = await Prefs.getString('token');
    Map<String,String> headers = {
      "Content-Type": "application/json",
      "token": token
    };
    var response = await http.get(
      ServerConfigurations.get_product_by_category+dropdownValue, headers: headers
    );
    if (response.statusCode == 404 ) {
      return List<Product>();
    }
    print(response.body);
    var productsDecoded = convert.json.decode(response.body);
    List<Product> products = _convertVarToTypedList(productsDecoded);
    return products;
  }

  static List<Product> _convertVarToTypedList(productsParsed) {
    final List<Product> products = List<Product>();
    for (dynamic currentProduct in productsParsed ) {
      Product product = Product.fromJson(currentProduct);
      products.add(product);
    }
    return products;
  }
}
