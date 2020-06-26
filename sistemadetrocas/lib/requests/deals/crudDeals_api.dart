import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:sistemadetrocas/model/ProductDeal.dart';

import 'package:sistemadetrocas/model/product.dart';
import 'package:sistemadetrocas/serverConfigurations/server_configuration.dart';
import 'package:sistemadetrocas/utils/prefs.dart';

class CrudDeal {

  static Future<void> create(Product myProduct, Product desiredProduct) async {
    String token = await Prefs.getString('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "token": token
    };
    Map params = {
      "productProponent": {
        "id" : myProduct.gProductId,
        "name" : myProduct.gName,
        "description" : myProduct.gDesc,
        "productCategory" : myProduct.gProdCat,
        "user": myProduct.gSignupUser,
        "imagePath": myProduct.gImgPath
      },
      "dealStatusUserProponent":"Proposta enviada",
      "productProposed": {
        "id" : desiredProduct.gProductId,
        "name" : desiredProduct.gName,
        "description" : desiredProduct.gDesc,
        "productCategory" : desiredProduct.gProdCat,
        "user": desiredProduct.gSignupUser,
        "imagePath": desiredProduct.gImgPath,
      },
      "dealStatusUserProposed":"Aguardando resposta"
    };
      String sParams = convert.json.encode(params);
      var response = await http.post(
        ServerConfigurations.create_deal_url,
        body: sParams, headers: headers );

    print(response.headers.toString());
    print(response.statusCode.toString());
  }

  static Future<bool> hasDeal() async {
    String token = await Prefs.getString('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "token": token
    };
    var response = await http.get(
        ServerConfigurations.has_pre_deal, headers: headers);

    print (response.body);
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<List<ProductDeal>> getDeal() async {
    String token = await Prefs.getString('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "token": token
    };
    var response = await http.get(
        ServerConfigurations.get_all_product_deal_url, headers: headers);

    if (response.statusCode == 404) {
      return List<ProductDeal>();
    }

    print(response.body);
    var productDealsDecoded = convert.json.decode(response.body);
    List<ProductDeal> productDeals = _convertVarToTypedList(productDealsDecoded);
    return productDeals;
  }

  static List<ProductDeal> _convertVarToTypedList(productDealsDecoded) {
    final List<ProductDeal> preDeals = List<ProductDeal>();
    for (dynamic currentPreDeal in productDealsDecoded ) {
      ProductDeal preDeal = ProductDeal.fromJson(currentPreDeal);
      preDeals.add(preDeal);
    }
    return preDeals;
  }
}