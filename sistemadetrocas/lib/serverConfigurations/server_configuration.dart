class ServerConfigurations {

  static const String url = "http://192.168.0.138:12345/";
  static const String create_user_url = url+"user/create";
  static const String login_url = url+"auth/login";
  static const String logout_url = url+"auth/logout";
  static const String create_product_url = url+"product/create";
  static const String get_all_my_product_url = url+"product/get-all-my-products";
  static const String delete_product_url = url+"product/delete-by-name/";
  static const String update_product_url = url+"product/update-by-name/";
  static const String get_product_by_name = url+"product/get-by-name/";
  static const String get_product_by_category = url+"product/get-by-category/";
  static const String create_deal_url = url+"deal/create";
  static const String has_pre_deal = url+"deal/has-deal";
  static const String get_all_product_deal_url = url+"deal/get-all-product-deal";
  static const String get_products_in_deal_url = url+"product/get-products-in-deal/";
  static const String update_reject_proposed_deal = url+"deal/delete-proposed-deal-by-id/";
  static const String update_accept_proposed_deal = url+"deal/accept-proposed-deal";
}