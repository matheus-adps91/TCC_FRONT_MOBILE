class ApiEntityResponse<T> {
  bool actionPerformed;
  String actionMsg;
  String textButton;

  ApiEntityResponse.success(this.actionPerformed) {
    actionMsg = "Operação concluída com sucesso";
    textButton = "OK";
  }

  ApiEntityResponse.fail(this.actionPerformed) {
    actionMsg = "Falha na operação";
    textButton = "Tentar Novamente";
  }
}
