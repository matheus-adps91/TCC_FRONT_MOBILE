import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:sistemadetrocas/model/product.dart';
import 'package:sistemadetrocas/serverConfigurations/server_configuration.dart';
import 'package:sistemadetrocas/utils/prefs.dart';

class CrudPreDeal {

  static String get token => token;

  static Future<void> create(Product myProduct, Product desiredProduct) async {
    String token = await Prefs.getString('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "token": token
    };
    Map params = {
      "idUserProponent" : myProduct.gSignupUser.gUserId,
      "idProdProponent" : myProduct.gProductId,
      "idUserProposed" : desiredProduct.gSignupUser.gUserId,
      "idProdProposed" : desiredProduct.gProductId
    };
    String sParams = convert.json.encode(params);
    var response = await http.post(
        ServerConfigurations.create_pre_deal_url,
        body: sParams, headers: headers);

    print(response.headers.toString());
    print(response.statusCode.toString());
  }

  static Future<bool> hasDeal() async {
    String token = await Prefs.getString('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "token": token
    };
    var response = await http.post(
        ServerConfigurations.has_pre_deal, headers: headers);

    print (response.body);
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<void> getPreDeal() async {
    String token = await Prefs.getString('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "token": token
    };
    var response = http.get(
      ServerConfigurations.get_all_my_pre_deal_url, headers: headers);

    print(response);
  }

}
