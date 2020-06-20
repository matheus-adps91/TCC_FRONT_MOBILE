import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sistemadetrocas/infrastructure/api_entityResponse.dart';
import 'package:sistemadetrocas/model/signupUser.dart';
import 'package:sistemadetrocas/serverConfigurations/server_configuration.dart';

class CrudUser {
  static Future<ApiEntityResponse<bool>> create(SignupUser user) async {
    var headers = {
      "Content-Type": "application/json"
    };
    var params = user.toJson();
    // Para enviar o cabeçalho em formato JSON, deve converter o MAP para STRING
    String sParams = json.encode(params);
    var response = await http.post(
        ServerConfigurations.create_user_url,
        body: sParams, headers: headers);

    print(response.headers.toString());
    print(response.statusCode.toString());

    if (response.statusCode == 201) {
      print('ANALISANDO STATUS CODE');
      return ApiEntityResponse.success(true);
    }
    return ApiEntityResponse.fail(false);
  }

}