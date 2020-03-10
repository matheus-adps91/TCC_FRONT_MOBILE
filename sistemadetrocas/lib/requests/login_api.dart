import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sistemadetrocas/infrastructure/api_response.dart';
import 'package:sistemadetrocas/model/usuario.dart';
import 'package:sistemadetrocas/utils/prefs.dart';

class LoginAPI {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    Map params = {'email': login, 'password': senha};
    // Para enviar o cabeçalho em formato JSON, deve converter o MAP para STRING
    String sParams = json.encode(params);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.post('http://192.168.43.234:12345/auth/login',
        body: sParams, headers: headers);

    if (response.statusCode == 201) {
      Map mapResponse = json.decode(response.body);
      String token = mapResponse['token'];
      String email = mapResponse['email'];
      String fullName = mapResponse['fullName'];
      Usuario usuario = Usuario(token, email, fullName);
      Prefs.setString('token', token);
      return ApiResponse.authenticated(usuario);
    }
    return ApiResponse.notAuthenticated("Usuário não autenticado");
  }
}
