import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sistemadetrocas/infrastructure/api_response.dart';
import 'package:sistemadetrocas/model/usuario.dart';

class LoginAPI {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    // URL para login
    final String urlLogin = 'http://192.168.1.39:12345/auth/login';

    Map<String, String> headers = {"Content-Type": "application/json"};
    Map params = {
      'email': login,
      'password': senha,
    };
    // Para enviar o cabeçalho em formato JSON, deve converter o MAP para STRING
    String sParams = json.encode(params);

    var response = await http.post(urlLogin, body: sParams, headers: headers);

    if (response.statusCode == 201) {
      Map mapResponse = json.decode(response.body);
      String token = mapResponse['token'];
      String email = mapResponse['email'];
      String fullName = mapResponse['fullName'];
      Usuario usuario = Usuario(token, email, fullName);
      return ApiResponse.authenticated(usuario);
    }
    return ApiResponse.notAuthenticated("Usuário não autenticado");
  }
}
