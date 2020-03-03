class ApiResponse<T> {
  bool userAuthenticated;
  String msg;
  T result;

  ApiResponse.authenticated(this.result) {
    userAuthenticated = true;
  }

  ApiResponse.notAuthenticated(this.msg) {
    userAuthenticated = false;
  }
}
