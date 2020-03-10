import 'dart:convert';
import 'package:sistemadetrocas/infrastructure/api_entityResponse.dart';
import 'package:sistemadetrocas/utils/prefs.dart';
import 'package:http/http.dart' as http;

class LogoutAPI {
  static Future<ApiEntityResponse<bool>> logout() async {
    String token = await Prefs.getString('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'token': token,
    };

    var response = await http.post('http://192.168.43.234:12345/auth/logout',
        headers: headers);

    print(response.statusCode);
    print(response.headers);
    print(response.body);

    Map mapResponse = json.decode(response.body);
    bool status = mapResponse['success'];
    print(status);
    if (response.statusCode == 200) {
      print('ANALISANDO STATUS CODE');
      return ApiEntityResponse.success(status);
    }
    return ApiEntityResponse.fail(status);
  }
}
