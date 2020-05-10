import 'package:sistemadetrocas/infrastructure/api_entityResponse.dart';
import 'package:sistemadetrocas/serverConfigurations/server_configuration.dart';
import 'package:sistemadetrocas/utils/prefs.dart';
import 'package:http/http.dart' as http;

class LogoutAPI {
  static Future<ApiEntityResponse<bool>> logout() async {
    String token = await Prefs.getString('token');
    var headers = {
      "Content-Type": "application/json",
      'token': token,
    };

    var response = await http.post(ServerConfigurations.logout_url,
        headers: headers);

    print(response.statusCode);
    print(response.headers);
    print(response.body);

    if (response.statusCode == 200) {
      print('ANALISANDO STATUS CODE');
      return ApiEntityResponse.success(true);
    }
    return ApiEntityResponse.fail(false);
  }
}
