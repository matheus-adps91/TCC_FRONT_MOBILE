import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sistemadetrocas/infrastructure/api_entityResponse.dart';

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
    String sParams = json.encode(params);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.post('http://192.168.1.33:12345/user/create',
        body: sParams, headers: headers);

    print(response.headers.toString());
    print(response.statusCode.toString());
    print(response.body.toString());

    Map mapResponse = json.decode(response.body);
    bool status = mapResponse['success'];
    if (response.statusCode == 201) {
      print('ANALISANDO STATUS CODE');
      return ApiEntityResponse.success(status);
    }
    return ApiEntityResponse.fail(status);
  }
}
