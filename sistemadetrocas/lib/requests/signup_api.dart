import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sistemadetrocas/infrastructure/api_entityResponse.dart';
import 'package:sistemadetrocas/serverConfigurations/server_configuration.dart';

class SignupAPI {
  static Future<ApiEntityResponse<bool>> signup(
      String email,
      String password,
      String fullName,
      String gender,
      String address,
      String houseNumber,
      String state,
      String city,
      String zipCode,
      String complement,
      bool compliance) async {
    var headers = {
      "Content-Type": "application/json"
    };
    Map params = {
      "email": email,
      "password": password,
      "fullName": fullName,
      "gender": gender,
      "address": address,
      "houseNumber": houseNumber,
      "state": state,
      "city": city,
      "zipCode": zipCode,
      "complement": complement,
      "compliance": compliance,
    };
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
