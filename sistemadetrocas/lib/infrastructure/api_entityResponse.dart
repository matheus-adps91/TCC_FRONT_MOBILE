class ApiEntityResponse<T> {
  String actionMsg;
  String textButton;
  bool status;

  ApiEntityResponse.success(bool status) {
    actionMsg = "Operação concluída com sucesso";
    textButton = "OK";
    this.status = status;
  }

  ApiEntityResponse.fail(bool status) {
    actionMsg = "Falha na operação";
    textButton = "Tentar Novamente";
    this.status = status;
  }
}
