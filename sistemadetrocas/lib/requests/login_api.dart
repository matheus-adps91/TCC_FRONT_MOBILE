import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sistemadetrocas/infrastructure/api_response.dart';
import 'package:sistemadetrocas/model/user.dart';
import 'package:sistemadetrocas/serverConfigurations/server_configuration.dart';
import 'package:sistemadetrocas/utils/prefs.dart';

class LoginAPI {
  static Future<ApiResponse<User>> login(String login, String senha) async {
    Map<String, String> headers = {
      "Content-Type": "application/json"
    };
    Map params = {
      'email': login,
      'password': senha
    };
    // Para enviar o cabeçalho em formato JSON, deve converter o MAP para STRING
    String sParams = json.encode(params);
    var response = await http.post(ServerConfigurations.login_url,
        body: sParams, headers: headers);

    if (response.statusCode == 201) {
      Map mapResponse = json.decode(response.body);
      String token = mapResponse['token'];
      String email = mapResponse['email'];
      String fullName = mapResponse['fullName'];
      int id = mapResponse['id'];
      User usuario = User(token, email, fullName, id);
      Prefs.setString('token', usuario.token);
      Prefs.setString('id', usuario.id.toString());
      return ApiResponse.authenticated(usuario);
    }
    return ApiResponse.notAuthenticated("Usuário não autenticado");
  }
}
