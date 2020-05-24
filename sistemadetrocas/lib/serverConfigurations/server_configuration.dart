class ServerConfigurations {

  static const String url = "http://192.168.1.41:12345/";
  static const String create_user_url = url+"user/create";
  static const String login_url = url+"auth/login";
  static const String logout_url = url+"auth/logout";
  static const String create_product_url = url+"product/create";
  static const String get_all_my_product_url = url+"product/get-all-my-products";
  static const String delete_product_url = url+"product/delete-by-name/";
  static const String update_product_url = url+"product/update-by-name/";
}