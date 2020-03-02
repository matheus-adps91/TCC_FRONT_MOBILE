// Classe para conter os métodos de validação de campos
class Validation {
  static String validateLogin(String value) {
    print('>>> FUNÇÃO: validateLogin');
    if (value.isEmpty) {
      return "Login não pode estar em branco";
    }
    if (!value.contains('@')) {
      return "Login inválido";
    }
    return null;
  }

  static String validatePassword(String value) {
    print('>>> FUNÇÃO: validatePassword');
    if (value.isEmpty) {
      return "Senha não pode estar em branco";
    }
    if (value.length < 4) {
      return "Senha deve conter pelo menos 4 caracteres";
    }
    return null;
  }

  static String validateZipCode(String value) {
    print('>>> FUNÇÃO: validateZipCode');
    if (value.isEmpty) {
      return "Código Postal não pode estar em branco";
    }
    if (value.length != 8) {
      return "Código Postal incorreto";
    }
    return null;
  }

  // Esse método é apenas para teste
  static String defaultValidation(String value) {
    print('>>> FUNÇÃO: defaultValidation');
    if (value.isEmpty) {
      return "VALIDAÇÃO TESTE";
    }
    return null;
  }

  // Esse método não é disparado pelo validate
  static bool validateConfirmPassword(String value, String anotherVlaue) {
    return value.hashCode != anotherVlaue.hashCode ? false : true;
  }
}
